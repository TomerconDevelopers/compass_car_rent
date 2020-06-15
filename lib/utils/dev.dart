import 'dart:convert';
import 'dart:io';

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