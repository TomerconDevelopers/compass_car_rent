import 'package:compass_rent_car/utils/user/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
//KISWeb holds whether platform is web or not (Boolean)
import 'package:flutter/foundation.dart' show kIsWeb;

import 'home.dart';
import 'intro.dart';
import 'utils/widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Compass rent car',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutterv Demo Home Page'),
      
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
SharedPreferences prefs;
class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => start(context));
  }
  void start(BuildContext){asyncFunc(BuildContext);}
  asyncFunc(BuildContext) async { 
    if (kIsWeb) {
    // running on the web!
    //No introslider, Directly to homepage
    Navigator.pushReplacement(
        BuildContext,
        MaterialPageRoute(builder: (context) => Login()),
      );

    } else {
     // NOT running on the web! You can check for additional platforms here.
     mobilespecific(BuildContext);
    }
  }
  // Introslider is required for android and ios.
  mobilespecific(BuildContext) async {
    prefs = await SharedPreferences.getInstance();
    var frun = prefs.getBool("frun");

    if(frun==true){
      //Navigate to home
      Navigator.pushReplacement(
        BuildContext,
        MaterialPageRoute(builder: (context) => Login()),
      );
    }
    else{
      //Navigate to Intro
      Navigator.pushReplacement(
        BuildContext,
        MaterialPageRoute(builder: (context) => Intro()),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            logo(),
            SizedBox(height:30),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
