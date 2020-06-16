import 'package:flutter/material.dart';

import '../globals.dart';

BoxDecoration bg(){
    return BoxDecoration(
      gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [grad1,grad2]),
              );
  }

ThemeData maintheme(){
    return ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.light,
        primaryColor: prim_color,
        accentColor: prim_color,

        // Define the default font family.
        fontFamily: 'Montserrat',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          subtitle: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),
        ));
  }
BoxDecoration rounded2(var col,bool bord,double r){
    return BoxDecoration(
      color: col,
        borderRadius: BorderRadius.circular(r),
        border: Border.all(
            color: (bord)?Colors.grey:Colors.transparent, style: BorderStyle.solid,
             width: 0.80),
      );
  }
  InputDecoration iprounded(String username, var ic)=> 
  InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
                        
          labelText: username,
          prefixIcon: Icon(ic),
          labelStyle: TextStyle(
                fontSize: 15
            )
        );