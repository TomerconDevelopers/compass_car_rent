import 'package:compass_rent_car/cardetails.dart';
import 'package:compass_rent_car/cardetails.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:compass_rent_car/manageusers.dart';
import 'package:compass_rent_car/utils/dev.dart';
import 'package:compass_rent_car/utils/tomform.dart';
import 'package:compass_rent_car/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';
import './utils/utils.dart' as ut;

import './globals.dart';
import './utils/styles.dart';
import 'utils/utils.dart';

class Dashboard extends StatefulWidget {
  //final String text,name;
  //Base({Key key, @required this.text,@required this.name}) : super(key: key);
  @override
  //BaseState createState() => new BaseState(text,name);
  DashboardState createState() => new DashboardState();
}
class DashboardState extends State<Dashboard> {

  /*
  String text;String name;
  BaseState(String a,String b){
    text = a;name = b;
    print("DATA from fisrt page: $text");
  }*/

  Map<dynamic,dynamic> cat = {
  "Maruti 800":{"name":"Beverages","ico":"Beverages/beverages"},
    "Omni 800":{"name":"Beverages","ico":"Cosmetics/nailpaint"},
    "Nissan":{"name":"Beverages","ico":"Dry fruits/dry fruits"},
    "Ford":{"name":"Beverages","ico":"Edible oil/edible oil"},
  "Innova XL":{"name":"Beverages","ico":"Fruits/fruits"},
  "BMW":{"name":"Beverages","ico":"Meat/meat"},
  "Mahindra Bolero":{"name":"Beverages","ico":"rice_and_floor/rice and flour"},
  "Maruti Suzuki Dzire":{"name":"Beverages","ico":"Stationary/stationary"},
  "BMW M8":{"name":"Beverages","ico":"Sweets/icecream"},
  "BMW 8 Series":{"name":"Beverages","ico":"Vegetables/tomato"},
    };
    List name = [];
  asyncFunc(BuildContext) async {
      http.
    get(resturl+"car",
    headers: headers).
      timeout(const Duration(seconds: 20)).catchError((err){
      print("${err}");}).then((value){
        if((value.statusCode==404)){ut.showtoast("Error", Colors.red);}else{
         print("${value.body}");
        setState(() {
          name =   json.decode(value.body);
          print("val:${name}");
          
        });

        }
      });
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
 
  }
   onDidReceiveLocalNotification(){}
  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  }
  getdata()async{
    ut.load(this, true);
  name.clear();
    http.
    get(resturl+"car",
    headers: headers).
      timeout(const Duration(seconds: 20)).catchError((err){
      print("${err}");}).then((value){
        if((value.statusCode==404)){ut.showtoast("Error", Colors.red);}else{
         print("${value.body}");
        setState(() {
          name =   json.decode(value.body);
          print("val:${name}");
          
        });

        }
      });
      ut.load(this, false);
  }
  addcar()async{
    ut.load(this,true);
    Map<dynamic,dynamic> config={};
    config["fields"]=
    [
           "model#text","number#text","make#text","colour#text","manufactureyear#text","expiryyear#text","price#text","photo#photo",
           "_id#text","purchasedate#date","partnershipdetails#text","isthimaradate#date","last_fuel_and_oil_change_kms#text",
           "oilchange_date#date","oilchange_cost#text","nextdue_km#text","tentative_date#date","repaidetails#text","repaicost#text","washing#text",
           "miscellanous#text"

    ];
    config["date"]=true;
    config["photopicker"] = true;
    config["title"] = "Add new";
    config["icon"] = Icons.directions_car;
    config["field_icon_color"] = Colors.orange[700];
    await Navigator.push(context,
      MaterialPageRoute(builder: (context) =>
         TomForm(config: config,)),)
        .then((var value) async {
      print("VAL:$value");
      var val = jsonDecode(value);
      val["rentuser"] = "null";
      val["date"] = 0;

      (value!=null)?await insert_car(val):ut.load(this,false);
    }); 
getdata();
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Compass Car Rent',
      theme: maintheme(),
      home: DefaultTabController(
        length: 3,
        child:Scaffold(
          appBar: AppBar(
            leading: Icon(Icons.directions_car),
            title: Text('COMPASS CAR RENT'),
            actions: [
              Row(children:[
                FlatButton.icon(
                    onPressed: (){
Navigator.push(context,MaterialPageRoute(builder: (context)=> ManageUser())).then((onval){
  getdata();
});

                    },
                    icon: Icon(Icons.person),
                    label: buttontext("Manage Users"),
                    color: Color(0xfff42d44),
                    hoverColor: Colors.amber,
                    textColor: Colors.white,
                    shape: ut.roundedborder(40)
                  ),
                  SizedBox(width:20),
                FlatButton.icon(
                    onPressed: (){
                      addcar();
                    },
                    icon: Icon(Icons.directions_car),
                    label: buttontext("Add Car"),
                    color: Color(0xfff42d44),
                    hoverColor: Colors.amber,
                    textColor: Colors.white,
                    shape: ut.roundedborder(40)
                  ),
                  SizedBox(width:20),
                
              ]),
              
            ],
            bottom: TabBar(
              
              tabs: [
                Tab(text: "All cars",),
                Tab(text: "Cars in garage",),
                Tab(text: "Cars on road"),
              ],
            ),
          ),
          body: TabBarView(
            children: [
                tabgen(1),       
                tabgen(2),       
                tabgen(3),       
            ],
          )
      ),
    ));
  }
  cardetailshandle(data){
Navigator.push(context,MaterialPageRoute(builder: (context)=> CarDetails(data: data,)));
    
  }
editcar(g) async{
   ut.load(this,true);
    Map<dynamic,dynamic> config={};
    config["fields"]=
    [
      "model#text","number#text","make#text","colour#text","manufactureyear#text","expiryyear#text","price#text",
           "purchasedate#date","partnershipdetails#text","isthimaradate#date",
      "rentuser#text","last_fuel_and_oil_change_kms#text",
           "oilchange_date#date","oilchange_cost#text","nextdue_km#text","tentative_date#date","repaidetails#text","repaicost#text","washing#text",
           "miscellanous#text",
      "date#date"
    ];
    config["date"] = true;
    config["initial"] = g;
    List<String> years = [];
    
    //years.clear();
    for(int i=2020;i>=2000;i--){
      years.add(i.toString());
    }
    config["year"] = years;
    config["test"] = ["red","blue","orange"];
    //config["accept_terms"] = true;
    config["title"] = "Add new";
    config["icon"] = Icons.supervisor_account;
    config["field_icon_color"] = Colors.orange[700];
    await Navigator.push(context,
      MaterialPageRoute(builder: (context) =>
          TomForm(config: config,)),).then((var value)  {
      print("#VAL:$value");
if(value !=null){
  http.
    patch(resturl+"car/"+g["_id"].toString(),
    headers: headers,body:value).
      timeout(const Duration(seconds: 20)).catchError((err){
      print("${err}");}).then((val){
        print("sasas sass "+val.statusCode.toString());
        ut.showtoast("Updated Successfully",Colors.green);
  getdata();

      //if(value!=null)edit(value);else asyncFunc(context);
    }); } });
ut.load(this, false);

}
convertdate(date)=>DateTime.fromMillisecondsSinceEpoch(int.parse(date.toString())).toString().split(' ')[0];


  deletecar(id){ return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[100],
          contentPadding: EdgeInsets.all(10),
          titlePadding: EdgeInsets.all(10),
          title:
          Text("Are you Sure to delete the car"),
          actions: [
            FlatButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("cancel")),
            FlatButton(onPressed: (){
              Navigator.pop(context);
   http.
    delete(resturl+"car/"+id.toString(),
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
  Widget tabgen(int type){
    List items=[];
    if(type == 1){
      items = name;
    }else if(type == 2){
      for ( var i in name ){
     i["rentuser"] == "null" ?    items.add(i) : print("asdad");
      }
    }else if (type == 3){
      for ( var i in name ){
     i["rentuser"] != "null" ?    items.add(i) : print("asdad");
      }
    }
   return Container(
                decoration: bg(),
                child:
                SingleChildScrollView(
                    child:
                    Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //Text("ffsf"),
                      Center(child:Container(
      //color: Colors.white,
        width: 1000,
              child: 
            items.isEmpty ? Container() :  ResponsiveGridList(
                scroll: false,
        desiredItemWidth: 300,
        minSpacing: 10,
        children: items.map((i) {
         // print("ajasad$i");
              return Container(
                color: Colors.white,
                height: 212,
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children:[
                        type == 3 ?   Container(
                          decoration: rounded(Colors.blue, 15)  ,margin:EdgeInsets.only(left:5), padding: EdgeInsets.symmetric(vertical:5,horizontal:8), child: Text("Return: "+convertdate(i["date"]),style: TextStyle(fontWeight:FontWeight.bold,color:Colors.white),)):Container(),
                        Expanded(child: SizedBox()),
                      InkWell(
                        onTap:()=> deletecar(i["_id"]),
                        child: 
                      ut.roundicon(Icons.delete, Colors.white, Colors.red, 17, 4)
                      ,)
                    ]),
                    CircleAvatar(
                radius: 40.0,
                backgroundImage:
                    NetworkImage("${i['photo']}"),
                backgroundColor: Colors.transparent,
              ),
          
                  Text("${i['model']}",style: TextStyle(fontSize: 18,
                  fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,),
                  Text("${i['number']}",
                  style: TextStyle(fontSize: 16,
                  color: Colors.blue),
                  textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:[
                    FlatButton.icon(
                        onPressed: (){
                          cardetailshandle(i);
                        },
                        icon: Icon(Icons.assignment),
                        label: buttontext("Details"),
                        color: Color(0xfff42d44),
                        hoverColor: Colors.amber,
                        //padding: EdgeInsets.zero,
                        textColor: Colors.white,
                        shape: ut.roundedborder(40)
                      ),
                      FlatButton.icon(
                        onPressed: (){
                          editcar(i);
                        },
                        icon: Icon(Icons.edit),
                        label: buttontext("Edit"),
                        color: Color(0xfff42d44),
                        hoverColor: Colors.amber,
                        textColor: Colors.white,
                        shape: ut.roundedborder(40)
                      ),
                  ])
                  
                ],));
        }).toList()
        
    )
    ))
                      ],
                    )
                ),
              );
  }
}
