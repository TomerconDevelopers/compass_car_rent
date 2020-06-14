import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.all(10),
      //color: Colors.blue,
      padding: EdgeInsets.only(left: 0,top: 20,right: 0,bottom: 20),
      child: TextField(
          
        decoration: InputDecoration(
          border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(50.0)),
          borderSide: BorderSide.none),
          filled: true,
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.amber[700],
          ),
          fillColor: Colors.grey[100],
          suffixIcon: Icon(Icons.sort,color: Colors.grey,),
          hintStyle: new TextStyle(color: Color(0xFFd0cece), 
              fontSize: 15),
          hintText: "Search products or categories",
        ),
      ),
    );
  }
}
