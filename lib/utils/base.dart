
import 'package:flutter/material.dart';
import '../utils/utils.dart' as ut;

import '../globals.dart';
import '../utils/styles.dart';

class Base extends StatefulWidget {
  //final String text,name;
  //Base({Key key, @required this.text,@required this.name}) : super(key: key);
  @override
  //BaseState createState() => new BaseState(text,name);
  BaseState createState() => new BaseState();
}
class BaseState extends State<Base> {

  /*
  String text;String name;
  BaseState(String a,String b){
    text = a;name = b;
    print("DATA from fisrt page: $text");
  }*/
  asyncFunc(BuildContext) async {

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
      title: 'Base',
      theme: maintheme(),
      home: Scaffold(
          appBar: AppBar(
            title: Text('Base'),
          ),
          body: Container(
            decoration: bg(),
            child:
            Center(
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Text("Base Activity")
                  ],
                )
            ),
          )
      ),
    );
  }
}
