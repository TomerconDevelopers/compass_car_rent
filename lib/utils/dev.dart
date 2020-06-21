import 'dart:convert';
import 'dart:io';

import 'package:compass_rent_car/utils/utils.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../globals.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

add_default_usertypes() async {
  var usertypes=[
      {"_id":"admin"},{"_id":"user"}
    ];
    final response = await http.
    post(resturl+"user_types/",
    headers: {
      "Content-type": "application/json",
      HttpHeaders.authorizationHeader: basicAuth,
      },
      body:json.encode(usertypes)
      ).
      timeout(const Duration(seconds: 20)).catchError((err){
      print("${err}");}).then((value){
        print("${value.body}");
      });
}
Future<dynamic> checkuserexists(String id) async {
  var stat;
  await http.
    get(resturl+"users/$id/",
    headers: headers).
      timeout(const Duration(seconds: 20)).catchError((err){
      print("${err}");}).then((value){
        (value.statusCode==404)?stat = false:
        stat = value.body;
      }); 
      return stat;
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
deleterent(id)async{
  http.
    patch(resturl+"car/"+id.toString(),
    headers: headers,body:json.encode({"rentuser":"null","date":"null"})).
      timeout(const Duration(seconds: 20)).catchError((err){
      print("${err}");}).then((value){
Fluttertoast.showToast(msg: "Updated Successfully",timeInSecForIosWeb: 5);
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
      }); 
}
List getusers(int page)  {
  http.
    get(resturl+"users?filter="+Uri.encodeFull("{'type':'user'}")+"&count=true&page="+page.toString()+"&pagesize=10&hal=f&np",
    headers: headers).
      timeout(const Duration(seconds: 20)).catchError((err){
      print("${err}");}).then((value){
        if((value.statusCode==404)){return {"error":value.statusCode.toString()};}else{
         print("${value.body}");
          List val =  json.decode(value.body);
          return val;
        }
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
      });
}
insert_car(Map data) async {
  UniqueKey id =UniqueKey();
  await http.
    put(resturl+"car/${data['_id']}",
    headers: {
      "Content-type": "application/json",
      HttpHeaders.authorizationHeader: basicAuth,
      },
      body:json.encode(data)
      ).
      timeout(const Duration(seconds: 20)).catchError((err){
      print("${err}");}).then((value){
        print("Car  inserted");
        //showtoast("Car inserted", Colors.green);
      });
}