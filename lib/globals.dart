import 'dart:collection';
import 'dart:io';
import 'package:mongo_dart/mongo_dart.dart' as mon;
import 'package:flutter/material.dart';

//STRINGS
String app_name = "foodle";
String slogan = "Needs on doors";
String bg_image = "assets/images/bg.png";
double logowidth = 140;double logoheight = 50;
//COLORS
Color prim_color = Colors.blueGrey;
Color themecol = Colors.blueGrey[800];
//BG GRADIENT
Color grad1 = Colors.yellow[600];Color grad2 = Colors.yellow[600];

Map<dynamic,dynamic> cu_perm = {};

List cla = [];
mon.Db db;
initmon() async {db = mon.Db((Platform.isAndroid)?mongourl:mongourlweb);
await db.open().then((val){print("$val");});}

//INSTITUTE
Map<dynamic,dynamic> insinfo;Map<dynamic,dynamic> userinfo;
Map<dynamic,dynamic> studentinfo;
//PRIVACY POLICY
String pp_url = "http://vps001.qubehost.com/progradeapp/beta/";

//=============== MONGO ===================
//LIVE
//String mongourl = "mongodb://sali:ssdssd46@vps001.qubehost.com:27017/prograde?authSource=prograde&authMechanism=SCRAM-SHA-1";
//LOCAL
String mongourl = "mongodb://10.0.2.2:27017/foodle";
String mongourlweb = "mongodb://127.0.0.1:27017/foodle";
//==========================================

//PHP server
//LOCAL
//String serurl = "http://10.0.2.2/prograde/";
//Error check
//String serurl = "http://localhost/";
//LIVE
String serurl = "http://vps001.qubehost.com/progradeapp";
Map<String, String> headers = {"Content-type": "application/json"};
String fcm_server_key = "AAAAvxQ1LGA:APA91bFD2sqIS-W0-aJgtEZ_yTxLgmGkGCKPfchRJqhmcWcaBFgt2LZGt9_GxO-gNlIg68NUz6quD_Xh4nl6FczQ2y8gSQoCJHjNaQ5gvIIWiSUGQX-jJIbSEMa1kt6DksAIHzPsMpJr";

