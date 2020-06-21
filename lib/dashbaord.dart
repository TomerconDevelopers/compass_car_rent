import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:compass_rent_car/manageusers.dart';
import 'package:compass_rent_car/utils/dev.dart';
import 'package:compass_rent_car/utils/tomform.dart';
import 'package:compass_rent_car/utils/widgets.dart';
import 'package:compass_rent_car/widgets/BrowsebyCategory.dart';
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

  }
  addcar()async{
    ut.load(this,true);
    Map<dynamic,dynamic> config={};
    config["fields"]=
    [
           "model#text","number#text","mileage#text","fuel#text","transmission#text","seating#text","price#text","photo#photo",
           "_id#text"

    ];
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
      val["date"] = "null";
      (value!=null)?insert_car(val):ut.load(this,false);
    }); 

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
      title: 'Compass car rent',
      theme: maintheme(),
      home: DefaultTabController(
        length: 3,
        child:Scaffold(
          appBar: AppBar(
            leading: Icon(Icons.directions_car),
            title: Text('Compass car rent'),
            actions: [
              Row(children:[
                FlatButton.icon(
                    onPressed: (){
Navigator.push(context,MaterialPageRoute(builder: (context)=> ManageUser()));

                    },
                    icon: Icon(Icons.person),
                    label: buttontext("Manage users"),
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
                    label: buttontext("Add car"),
                    color: Color(0xfff42d44),
                    hoverColor: Colors.amber,
                    textColor: Colors.white,
                    shape: ut.roundedborder(40)
                  ),
                  SizedBox(width:20),
                FlatButton.icon(
                    onPressed: (){},
                    icon: Icon(Icons.settings),
                    label: buttontext("Settings"),
                    color: Color(0xfff42d44),
                    hoverColor: Colors.amber,
                    textColor: Colors.white,
                    shape: ut.roundedborder(40)
                  ),
              ]),
              SizedBox(width:100)
              
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
                height: 200,
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
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
                        onPressed: (){},
                        icon: Icon(Icons.assignment),
                        label: buttontext("Details"),
                        color: Color(0xfff42d44),
                        hoverColor: Colors.amber,
                        //padding: EdgeInsets.zero,
                        textColor: Colors.white,
                        shape: ut.roundedborder(40)
                      ),
                      FlatButton.icon(
                        onPressed: (){},
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
