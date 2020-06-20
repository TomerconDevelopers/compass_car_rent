import 'package:cached_network_image/cached_network_image.dart';
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
  var _scroll1;
  int page=1;
 bool p = false;
 List user=[];
 var a;
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
          var val = json.decode(value);
          val["type"] = 'user';
      print("VAL:$value");
      (value!=null)?
      insertifnotexitsuser(json.decode(value)['_id'],val):ut.load(this,false);
    }); 

} 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Base',
      theme: maintheme(),
      home: Scaffold(
          appBar: AppBar(
            title: Text('Users'),
            actions: [
             Padding(

  padding: EdgeInsets.all(15),                            child: FlatButton.icon(
                 
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
          body: Container(
            decoration: bg(),
            child:
            a == null ? empty_server("NO users Found"):
            ListView.builder(
              itemCount: a.length,
              itemBuilder: (context,index){
              return Container(
                margin: EdgeInsets.all(4),
                decoration: ut.mycard(Colors.white, 10.0, 5.0),
                child: 
              ListTile(
                leading: 
                  CircleAvatar(
                radius: 30.0,
                backgroundImage:
                    NetworkImage("${a[index]['photo']}"),
                backgroundColor: Colors.transparent,
              )
                    ,
                title: Text("${a[index]['name']}"),
                subtitle: Text("  ${a[index]['_id']}"),
                ),);
            }
          )
      ),
    ));
  }
}
