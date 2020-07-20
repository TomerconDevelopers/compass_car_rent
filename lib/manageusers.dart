import 'dart:io';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:compass_rent_car/main.dart';
import 'package:compass_rent_car/utils/tomform.dart';
import 'package:compass_rent_car/utils/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:compass_rent_car/utils/common/vars.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/animation.dart';
import 'dart:convert';
import 'package:compass_rent_car/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'utils/utils.dart' as ut;
import 'globals.dart';
import 'utils/styles.dart';

class ManageUser extends StatefulWidget {
  //final String text,name;
  //Base({Key key, @required this.text,@required this.name}) : super(key: key);
  @override
  //BaseState createState() => new BaseState(text,name);
  ManageUserState createState() => new ManageUserState();
}
class ManageUserState extends State<ManageUser> with TickerProviderStateMixin {

  AnimationController controller;
  Animation<double> animation;
TextEditingController searchcontroller = new TextEditingController();

  /*
  String text;String name;
  BaseState(String a,String b){
    text = a;name = b;
    print("DATA from fisrt page: $text");
  }*/
  int userview=0;
  int index=0;
  var _scroll1;
  int page=1;
 bool p = false;
 List user=[];
 var a;
 
  bool stat=false;
  List cardetails=[];
 getdata(){
   http.
    get(resturl+"users?filter="+Uri.encodeFull("{'type':'user'}"),
    headers: headers).
      timeout(const Duration(seconds: 20)).catchError((err){
      print("${err}");}).then((value){
        if((value.statusCode==404)){ var eroor =  {"error":value.statusCode.toString()};}else{
         print("${value.body}");
         setState(() {
         
            a = json.decode(value.body);
            print(a);
        //   print(a[0]["photo"]);
  }); 
        }
      });
 
   print("sadadad${user}");
 }
  asyncFunc(BuildContext) async {
    _scroll1= new ScrollController();
   getdata();
  /*  _scroll1.addListener(() {
      if (_scroll1.position.pixels == _scroll1.position.maxScrollExtent) {
        setState(() {
          if (p == false) {
            page = page + 1;
            getdata();
          }
        });
    
  }
    });*/
  }
  bool myinterceptor(bool stopDefaultButtonEvent){
    if(index == 1){
      setState(() {
        index=0;
      });
      return true;
    }else{
      return false;
    }
  }
  deleteuser(id){ return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[100],
          contentPadding: EdgeInsets.all(10),
          titlePadding: EdgeInsets.all(10),
          title:
          Text("Are you Sure to delete the user"),
          actions: [
            FlatButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("cancel")),
            FlatButton(onPressed: (){
              Navigator.pop(context);
   http.
    delete(resturl+"users/"+id.toString(),
    headers: headers).
      timeout(const Duration(seconds: 20)).catchError((err){
      print("${err}");}).then((value){
        if((value.statusCode==404)){ var eroor =  {"error":value.statusCode.toString()};}else{
         print("${value.body}");
        ut.showtoast("Deleted SuccessFUlly", Colors.green);
        getdata();
        }
      });
  
            }, child: Text("ok"))
          ],
          );});
   
  }
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeInBack);
    BackButtonInterceptor.add(myinterceptor);
    WidgetsBinding.instance.addPostFrameCallback((_) => start(context));
  controller.forward();
  }
  void start(BuildContext){
    asyncFunc(BuildContext);
  }
  @override void dispose() {super.dispose();BackButtonInterceptor.remove(myinterceptor);}

  adduser()async{
    ut.load(this,true);
    Map<dynamic,dynamic> config={};
    config["fields"]=
    [
           "name#text","number#text","landline#text","officeaddress#text","homeaddress#text","QIDNO#text","QIDexpiry#date","_id#text","pwd#text","photo#photo","licenseno#text",
  "licensetype#text","licenseexpiry#date","CNO#text","status#dropdown"
    ];
    config["status"] = ["Hold","Active"];
    config["date"] = true;
    config["photopicker"] = true;
    config["title"] = "Add new";
    config["icon"] = Icons.account_circle;
    config["field_icon_color"] = Colors.orange[700];
    await Navigator.push(context,
      MaterialPageRoute(builder: (context) =>
         TomForm(config: config,)),)
        .then((var value) async {
          if(value != null){
          var val = json.decode(value);
          val["type"] = 'user';
      print("VAL:$value");
      (value!=null)?
    await  insertifnotexitsuser(json.decode(value)['_id'],val):ut.load(this,false);

        }}); 
ut.load(this, false);
} 

  edituser()async{
    ut.load(this,true);
    Map<dynamic,dynamic> config={};
    config["fields"]=
    [
           "name#text","number#text","landline#text","officeaddress#text","homeaddress#text","QIDNO#text","QIDexpiry#date","pwd#text","licenseno#text",
  "licensetype#text","licenseexpiry#date","CNO#text","status#dropdown"
    ];
    config["status"] = ["Hold","Active"];
    config["date"] = true;
    config["photopicker"] = true;
    config["title"] = "Edit";
    config["initial"] = a[userview];
    
    config["icon"] = Icons.account_circle;
    config["field_icon_color"] = Colors.orange[700];
    await Navigator.push(context,
      MaterialPageRoute(builder: (context) =>
         TomForm(config: config,)),)
        .then((var value) async {
          if(value != null){
          var val = json.decode(value);
          val["type"] = 'user';
      print("VAL:$value");
    http.
    patch(resturl+"users/"+a[userview]["_id"].toString(),
    headers: headers,body:value).
      timeout(const Duration(seconds: 20)).catchError((err){
      print("${err}");}).then((value){
        print("sasas sass "+value.statusCode.toString());
   Fluttertoast.showToast(backgroundColor: Colors.green, msg: "Updated Successfully",timeInSecForIosWeb: 5);
  getdata(); 
        });
        } });  
ut.load(this, false);
} 
insertifnotexitsuser(String id,Map data) async {
  http.
    get(resturl+"users/$id/",
    headers: headers).
      timeout(const Duration(seconds: 20)).catchError((err){
      print("${err}");}).then((value){
        (value.statusCode==404)?insert_user(id, data):
        print("User already exists");
      }); 
}
insert_user(String id,Map data) async {
  await http.
    put(resturl+"users/$id/",
    headers: {
      "Content-type": "application/json",
      HttpHeaders.authorizationHeader: basicAuth,
      },
      body:json.encode(data)
      ).
      timeout(const Duration(seconds: 20)).catchError((err){
      print("${err}");}).then((value){
        print("User $id inserted");
        getdata();
      });
}
List _searchResult = [];
 onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    a.forEach((userDetail) {
      if (userDetail["name"].toString().toLowerCase().contains(text.toLowerCase()))
        _searchResult.add(userDetail);
    });

    setState(() {});
  }

genagreement(car,user)async {
  var config={};
  config["fields"] = ["terms#textarea"];
   
    config["title"] = "Terms and Conditions.";
    //print(prefs.getString("terms"));
    if(prefs.getString("terms") != null){ 
      String dat = prefs.getString("terms").toString();
      config["initial"] ={"terms": dat};
      }
    
    config["icon"] = Icons.assignment;
    config["field_icon_color"] = Colors.orange[700];
  Navigator.push(context, MaterialPageRoute(builder: (context)=>TomForm(config: config) )).then((onValue)async{
    if(onValue != null){

String terms = "1 don no crack car<br>2 sadasdaddd<br>3 dsfsdfsf";
prefs.setString("terms", json.decode(onValue)['terms'].toString());
 // var htmlContent = ut.createagreement(user, car,json.decode(onValue)['terms']) ;
  //var url = 'http://localhost:8085/odf.php?data1='+Uri.encodeFull(ut.getsetyle().toString())+"&data2="+Uri.encodeFull(ut.uptoremarks(user, car, json.decode(onValue)['terms'])+"&data3="+Uri.encodeFull(ut.afterremarks(user, car, json.decode(onValue)['terms'])));

 var url = "$serverurl/pdf.php?QIDNO=${user['QIDNO']}&QIDexpiry=${ut.convertdate(user['QIDexpiry'])}&licenseno=${user['licenseno']}&licenseexpiry=${user['licenseexpiry']}&homeaddress=${user['homeaddress']}&landline=${user['landline']}&officeaddress=${user['officeaddress']}&number=${user['number']}&vnumber=${car['number']}&make=${car['make']}&color=${car['colour']}&model=${car['model']}&date=${ut.convertdate(car['date'])}&price=${car['price']}&terms=${Uri.encodeFull(json.decode(onValue)['terms'])}";
 if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}});}
  
String generatedPdfFilePath;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Base',
      theme: maintheme(),
      home: Scaffold(
          appBar: AppBar(
            leading:  index == 1 ?  BackButton(onPressed:(){
              setState(() {
                index=0;
              });
            }) : Container(),
            title: Text('Users'),
            actions: [
             Padding(

  padding: EdgeInsets.all(15),     
  child: index == 1 ? FlatButton.icon(
   onPressed: (){
                        edituser();
                     
                     
                      },
                      icon: Icon(Icons.edit),
                      label: buttontext("Edit"),
                      color: Color(0xfff42d44),
                      hoverColor: Colors.amber,
                      //padding: EdgeInsets.zero,
                      textColor: Colors.white,
                      shape: ut.roundedborder(40.0)
                    )
 : FlatButton.icon(
   onPressed: (){
                        adduser();
                     getdata();
                     
                     
                      },
                      icon: Icon(Icons.add),
                      label: buttontext("Add User"),
                      color: Color(0xfff42d44),
                      hoverColor: Colors.amber,
                      //padding: EdgeInsets.zero,
                      textColor: Colors.white,
                      shape: ut.roundedborder(40.0)
                    ),
             )
            ],
          ),
          body: IndexedStack(
            index: loading ? 2 :  index,
            children: [
              FadeTransition(
                opacity: animation,
                              child: Container(
                  decoration: bg(),
                  child:
                  a == null ? empty_server("NO users Found"):
                a.length == 0 ? empty_server("No user found") :  Column(
                  children: <Widget>[
                    Container(
                    height: 45,
                      color:Colors.red[200],
                      child:Row(
                        
                        children: <Widget>[
                          SizedBox(width:3),
                    Icon(Icons.account_circle),  Text("  ${  a.length}"),
                      Expanded(child: SizedBox()),
                       Padding(
                         padding: const EdgeInsets.only(left:10.0),
                         child: Container(
                      margin: EdgeInsets.only(top:7,bottom: 7),

                  decoration: rounded(Colors.white30, 30),
                  child:
                  Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                      child:
 Container(
        
        width: 350,
        child:TextFormField(
        controller: searchcontroller,
        maxLines: 1,  
          decoration: new InputDecoration(
            contentPadding: EdgeInsets.only(bottom:13),
            fillColor: Colors.white,
            hintText: "search user",
            border: InputBorder.none
          ),
          onChanged:onSearchTextChanged,
          keyboardType: TextInputType.text,

          style: new TextStyle(
            color: Colors.black,
            fontFamily: "Poppins",
          ),
        ))
                  )),
                       ),
                     InkWell(
                       onTap: (){
                         searchcontroller.clear();
                    onSearchTextChanged('');
                       },
                       child:  ut.roundicon(Icons.cancel, Colors.white30, Colors.transparent, 30, 4)
                     )
                    ],)),
                    Expanded(
                                          child: 
                                          
                                       _searchResult.length != 0 || searchcontroller.text.isNotEmpty ?
                                       ListView.builder(
                          itemCount: _searchResult.length,
                          itemBuilder: (context,ind){
                            print("here at");
                          return Container(
                            margin: EdgeInsets.all(4),
                           decoration: ut.mycard(Colors.white, 10.0, 5.0),
                            child: 
                          ListTile(
                            onTap: (){
                              setState(() {
                                index = 1;
                                userview = a.indexOf(_searchResult[ind]);
                                
                       getcardetails(a[userview]['_id']);
                              });
                            },
                            leading: 
                              CircleAvatar(
                            radius: 30.0,
                            backgroundImage:
                                NetworkImage("${_searchResult[ind]['photo']}"),
                            backgroundColor: Colors.transparent,
                          )
                                ,
                            title: Text("${_searchResult[ind]['name']}"),
                            subtitle: Text("  ${_searchResult[ind]['_id']}"),
                            trailing: InkWell(
                                onTap: (){
                                  deleteuser(_searchResult[ind]['_id']);
                                } ,
                              child: 
                            ut.roundicon(Icons.delete, Colors.white, Colors.red, 15, 4),),
                            ),
                            
                            );
                        }
                      )
                                          : ListView.builder(
                          itemCount: a.length,
                          itemBuilder: (context,ind){
                            print("here at");
                          return Container(
                            margin: EdgeInsets.all(4),
                           decoration: ut.mycard(Colors.white, 10.0, 5.0),
                            child: 
                          ListTile(
                            onTap: (){
                              setState(() {
                                index = 1;
                                userview = ind;
                                
                       getcardetails(a[userview]['_id']);
                              });
                            },
                            leading: 
                              CircleAvatar(
                            radius: 30.0,
                            backgroundImage:
                                NetworkImage("${a[ind]['photo']}"),
                            backgroundColor: Colors.transparent,
                          )
                                ,
                            title: Text("${a[ind]['name']}"),
                            subtitle: Text("  ${a[ind]['_id']}"),
                            trailing: InkWell(
                                onTap: (){
                                  deleteuser(a[ind]['_id']);
                                } ,
                              child: 
                            ut.roundicon(Icons.delete, Colors.white, Colors.red, 15, 4),),
                            ),
                            
                            );
                        }
                      ),
                    ),
                  ],
                )
      ),
              ), a==null ? empty_server("No Users found") : a.length == 0 ? empty_server("No Users found"): viewprofile() , loader()
            ],
          ),
    ));
  }
getcardetails(String id)async{
  cardetails.clear();
  var stat;
  await http.
    get(resturl+"car?filter="+Uri.encodeFull("{'rentuser':'$id'}"),
    headers: headers).
      timeout(const Duration(seconds: 20)).catchError((err){
      print("${err}");}).then((value){
        if(value.statusCode==404){
          setState(() {
            stat = false;
          }); 
          }
       else { 
         setState((){
       stat = true;
       cardetails.clear();
       cardetails = jsonDecode(value.body);
        }); 
        }
      }); 
      
        return;
}deleterent(id)async{
  http.
    patch(resturl+"car/"+id.toString(),
    headers: headers,body:json.encode({"rentuser":"null","date":"null"})).
      timeout(const Duration(seconds: 20)).catchError((err){
      print("${err}");}).then((value){
Fluttertoast.showToast(msg: "Updated Successfully",timeInSecForIosWeb: 5);
getcardetails(a[userview]['_id']);
      }); 
}
update_car(Map data) async {
  http.
    get(resturl+"car/${data["id"]}/",
    headers: headers).
      timeout(const Duration(seconds: 20)).catchError((err){
      print("${err}");}).then((value){
        (value.statusCode !=404)? jsonDecode(value.body)['rentuser'] == "null" ?  update_car_verified(data)  : 
        Fluttertoast.showToast(msg: "Car Already Taken",timeInSecForIosWeb: 5) :
        Fluttertoast.showToast(msg: "Car Does NOt Exists",timeInSecForIosWeb: 5);
      }); 
      }
      update_car_verified(Map data) async {
  http.
    patch(resturl+"car/"+data["id"],
    headers: headers,body:json.encode(data)).
      timeout(const Duration(seconds: 20)).catchError((err){
      print("${err}");}).then((value){
Fluttertoast.showToast(msg: "Updated Successfully",timeInSecForIosWeb: 5);
getcardetails(a[userview]['_id']);

      }); 
}
extendcar(id) async{
  ut.load(this,true);
    Map<dynamic,dynamic> config={};
    config["fields"]=
    [
           
           "date#date"

    ];
    config["date"] = true;
    config["title"] = "Add new";
    config["icon"] = Icons.directions_car;
    config["field_icon_color"] = Colors.orange[700];
    await Navigator.push(context,
      MaterialPageRoute(builder: (context) =>
         TomForm(config: config,)),)
        .then((var value) async {
      print("VAL:$value");
      var val = jsonDecode(value);
      val["id"] = id;
      //val["rentuser"] = a[userview]["_id"];
       http.
    patch(resturl+"car/"+val["id"],
    headers: headers,body:json.encode(val)).
      timeout(const Duration(seconds: 20)).catchError((err){
      print("${err}");}).then((value){
Fluttertoast.showToast(msg: "Updated Successfully",timeInSecForIosWeb: 5);
getcardetails(a[userview]['_id']);

      }); 
    }); 
      
    
ut.load(this, false);
}
convertdate(date)=>DateTime.fromMillisecondsSinceEpoch(int.parse(date.toString())).toString().split(' ')[0];

deletecar(id) async{
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[100],
          contentPadding: EdgeInsets.all(10),
          titlePadding: EdgeInsets.all(10),
          title:
          Text("Are you Sure to delete the rent details of the car"),
          actions: [
            FlatButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("CANCEL")),
            FlatButton(onPressed: (){
              Navigator.pop(context);
  ut.load(this,true); 
      deleterent(id);
getcardetails(a[userview]['_id']);
    
ut.load(this, false);            
              },child: Text("YES"),)]);});
  
}

rentcar() async{
  ut.load(this,true);
    Map<dynamic,dynamic> config={};
    config["fields"]=
    [
           
           "id#text","date#date"

    ];
    config["date"] = true;
    config["title"] = "Add new";
    config["icon"] = Icons.directions_car;
    config["field_icon_color"] = Colors.orange[700];
    await Navigator.push(context,
      MaterialPageRoute(builder: (context) =>
         TomForm(config: config,)),)
        .then((var value) async {
     if((value!=null)){ print("VAL:$value");
      var val = jsonDecode(value);
      val["rentuser"] = a[userview]["_id"];
      
        update_car(val);}
      ut.load(this,false);
    });
ut.load(this, false);
}
  Widget viewprofile(){
    if(a == null){
      return Container();
    } else{
      print(cardetails.runtimeType);
    return Container(child: Row(
      children:[
      Container(
        width: MediaQuery.of(context).size.width*0.48,
      decoration:ut.mycard(Colors.white, 8.0, 3.0),
        padding: EdgeInsets.all(13),
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Center(
            child: CircleAvatar(
              
                  radius: 70.0,
                  backgroundImage:
                      NetworkImage("${a[userview]['photo']}"),
                  backgroundColor: Colors.transparent,
                ),
          ),
              SizedBox(height:10),
              Text("Name :  ${a[userview]['name']}"),
              SizedBox(height:10),
                Text("ID :  ${a[userview]['_id']}"),
              SizedBox(height:10),
                Text("Contact :  ${a[userview]['number']}"),
              SizedBox(height:10),
                Text("Office Address :  ${a[userview]['officeaddress']}"),
              SizedBox(height:10),
                Text("Home Address :  ${a[userview]['homeaddress']}"),
              SizedBox(height:10),
                Text("QID NO :  ${a[userview]['QIDNO']}"),
              SizedBox(height:10),
                Text("QIP Expiry  :  ${convertdate(a[userview]['QIDexpiry'])}"),
              SizedBox(height:10),
                Text("License No :  ${a[userview]['licenseno']}"),
              SizedBox(height:10),
                Text("License Type :  ${a[userview]['licensetype']}"),
              SizedBox(height:10),
                Text("License Expiry :  ${convertdate(a[userview]['licenseexpiry'])}"),
              SizedBox(height:10),
                Text("CNO :  ${a[userview]['CNO']}"),
            
              SizedBox(height:10),
                Text("Status :  ${a[userview]['status']}"),
            
              SizedBox(height:10),
                Text("LandLine :  ${a[userview]['landline']}"),
            
        ],),
      ),
      Container(
                //decoration:ut.mycard(Colors.white, 8.0, 3.0),
width: MediaQuery.of(context).size.width*0.48,
        padding: EdgeInsets.only(top:15,left: 19),
        margin: EdgeInsets.all(0),
        child:Column(children: [
        Container(
          decoration: rounded(Colors.red, 13.0),
          child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Car Details",style: TextStyle(color:Colors.white),),
            ),
           InkWell(
             onTap: (){
               rentcar();
             },
             child: ut.roundicon(Icons.add, Colors.white, Colors.blue, 14, 5))
          ],
        ),),
     cardetails == null  ? Text("no data") : Padding(
       padding: const EdgeInsets.all(8.0),
       child: Column(children: 
       cardetails.map<Widget>((f) => Row(
         children: [
           Container(
            
             child: Text("${f['model']}   ${f["number"]}")),
           Expanded(child: SizedBox()),
           Text("${  DateTime.fromMillisecondsSinceEpoch(int.parse(f['date'].toString())).toString().split(' ')[0]}"),
           SizedBox(width:0),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: InkWell(
               
               onTap: (){
                 extendcar(f['_id']);
    getcardetails(a[userview]["_id"]);

               },
               child:            ut.roundicon(Icons.arrow_upward, Colors.white, Colors.blue, 17, 5),
),
           ),
           InkWell(
             onTap: (){
              genagreement(f,a[userview]);
             },
             child: 
           ut.roundicon(Icons.print, Colors.white, Colors.green, 17, 5),),
           InkWell(
             onTap: (){
              deletecar(f['_id']);
             },
             child: 
           ut.roundicon(Icons.delete, Colors.white, Colors.black54, 12, 5),)
         ],
        ),).toList()
       ,),
     )  
      ],))
    ]),);
    }  }

}
