import 'package:fluttertoast/fluttertoast.dart';
import "package:intl/intl_browser.dart";

import 'package:cached_network_image/cached_network_image.dart';
import 'package:compass_rent_car/utils/common/vars.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:compass_rent_car/utils/dev.dart';
import 'package:compass_rent_car/utils/tomform.dart';
import 'package:compass_rent_car/utils/widgets.dart';
import 'package:flutter/material.dart';
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
class ManageUserState extends State<ManageUser> {

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
           print(a[0]["photo"]);
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
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => start(context));
  }
  void start(BuildContext){
    asyncFunc(BuildContext);
  }
  @override void dispose() {super.dispose();}

  adduser()async{
    ut.load(this,true);
    Map<dynamic,dynamic> config={};
    config["fields"]=
    [
           "name#text","number#text","address#text","_id#text","pwd#text","photo#photo",

    ];
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
      insertifnotexitsuser(json.decode(value)['_id'],val):ut.load(this,false);
        }}); 
ut.load(this, false);
} 
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
  child: FlatButton.icon(
   onPressed: (){
                        adduser();
                      },
                      icon: Icon(Icons.add),
                      label: buttontext("Add User"),
                      color: Color(0xfff42d44),
                      hoverColor: Colors.amber,
                      //padding: EdgeInsets.zero,
                      textColor: Colors.white,
                      shape: ut.roundedborder(40)
                    ),
             )
            ],
          ),
          body: IndexedStack(
            index: loading ? 2 :  index,
            children: [
              Container(
                decoration: bg(),
                child:
                a == null ? empty_server("NO users Found"):
                ListView.builder(
                  itemCount: a.length,
                  itemBuilder: (context,ind){
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
                    ),);
                }
              )
      ), viewprofile() , loader()
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

deletecar(id) async{
  ut.load(this,true); 
      deleterent(id);
getcardetails(a[userview]['_id']);
    
ut.load(this, false);
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
    return Container(child: ListView(children:[
      Container(
        width: double.infinity,
        decoration:ut.mycard(Colors.white, 8, 3),
        padding: EdgeInsets.all(13),
        margin: EdgeInsets.all(10),
        child: Column(children: [
          CircleAvatar(
                radius: 70.0,
                backgroundImage:
                    NetworkImage("${a[userview]['photo']}"),
                backgroundColor: Colors.transparent,
              ),
              SizedBox(height:10),
              Text("Name :  ${a[userview]['name']}"),
              SizedBox(height:10),
                Text("ID :  ${a[userview]['_id']}"),
              SizedBox(height:10),
                Text("Contact :  ${a[userview]['number']}"),
            
        ],),
      ),
      Container(
                //decoration:ut.mycard(Colors.white, 8, 3),

        padding: EdgeInsets.all(13),
        margin: EdgeInsets.all(10),
        child:Column(children: [
        Container(
          color: Colors.red,
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
           Text("${f['model']}   ${f["number"]}"),
           Expanded(child: SizedBox()),
           Text("${  DateTime.fromMillisecondsSinceEpoch(int.parse(f['date'].toString())).toString().split(' ')[0]}"),
           SizedBox(width:10),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: InkWell(
               
               onTap: (){
                 extendcar(f['_id']);
    getcardetails(a[userview]["_id"]);

               },
               child: roundedtext("Extend", Colors.blue, Colors.white, 8, 14)),
           ),
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
