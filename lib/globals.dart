import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

//STRINGS
String app_name = "compass car rent";
String slogan = "Needs on doors";

double logowidth = 140;double logoheight = 50;
//COLORS
//Color(0xffff2d55)
Color prim_color = Color(0xffff2d55);
Color themecol = Colors.blueGrey[800];
//BG GRADIENT
Color grad1 = Colors.grey[100];
Color grad2 = Colors.grey[200];

Map<dynamic,dynamic> cu_perm = {};


//INSTITUTE
Map<dynamic,dynamic> insinfo;Map<dynamic,dynamic> userinfo;
Map<dynamic,dynamic> studentinfo;
//PRIVACY POLICY
String pp_url = "http://vps001.qubehost.com/progradeapp/beta/";

//resthearturl
String resturl = "http://localhost:8080/compass_car_rent/";
String username = 'admin';
  String password = 'secret';
  String basicAuth =
      'Basic ' + base64Encode(utf8.encode('$username:$password'));


String imageurl = "http://vps001.qubehost.com/progradeapp";
Map<String, String> headers = {
      "Content-type": "application/json",
      HttpHeaders.authorizationHeader: basicAuth,
      };
String fcm_server_key = "AAAAvxQ1LGA:APA91bFD2sqIS-W0-aJgtEZ_yTxLgmGkGCKPfchRJqhmcWcaBFgt2LZGt9_GxO-gNlIg68NUz6quD_Xh4nl6FczQ2y8gSQoCJHjNaQ5gvIIWiSUGQX-jJIbSEMa1kt6DksAIHzPsMpJr";

