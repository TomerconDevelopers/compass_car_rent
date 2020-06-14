import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
//import './utils/common/vars.dart';

import 'globals.dart';
//import 'home.dart';

//INtro slider
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';


class Intro extends StatefulWidget {
  @override
  IntroState createState() => new IntroState();
}
//Handle back button
//#DD5877

double imgsize = 300.0;
class IntroState extends State<Intro> {

  List<Slide> slides = new List();
  @override
  void initState() {
    super.initState();
    slides.add(
      new Slide(
        title: "Welcome to",
        styleTitle: TextStyle(color: Colors.black, fontSize: 35),
        styleDescription: TextStyle(color:Colors.black, fontSize: 25),
        description: slogan,
        pathImage: "assets/images/logo.png",
        maxLineTitle:3,
        backgroundImage: "assets/images/intro1bg.png",
        backgroundOpacity: 0,
        widthImage:imgsize,
        heightImage:imgsize,
        backgroundColor: Colors.teal[300],
      ),
    );
    slides.add(
      new Slide(
        title: "Instant Delivery",
        description: "Just a tap required, The order will be at your doors.",
        //pathImage: "images/intro3.png",
        backgroundImage: "assets/images/intro2bg.png",
        styleTitle: TextStyle(color: Colors.black, fontSize: 35),
        styleDescription: TextStyle(color:Colors.black, fontSize: 25),
        backgroundOpacity: 0,
        centerWidget: Icon(Icons.shopping_cart,size: 100,color: Colors.black,),
        widthImage:imgsize,
        heightImage:imgsize,
        backgroundColor: Colors.red[400],
      ),
    );
    slides.add(
      new Slide(
        title: "Best offers",
        styleTitle: TextStyle(color: Colors.black, fontSize: 35),
        styleDescription: TextStyle(color:Colors.black, fontSize: 25),
        description: "Everybody like offers. \n Yeah! We too",
        centerWidget: Icon(Icons.redeem,size: 100,color: Colors.black,),
        maxLineTitle:3,
        backgroundImage: "assets/images/intro1bg.png",
        backgroundOpacity: 0,
        widthImage:imgsize,
        heightImage:imgsize,
        backgroundColor: Color(0xff29B6F6),
      ),
    );
    slides.add(
      new Slide(
        title: "Want some more interesting stuffs",
        description:
        "Get Started",
        pathImage: "assets/images/logo.png",
        widthImage:imgsize,
        heightImage:imgsize,
        maxLineTitle:2,
        backgroundColor: Colors.red[700]
      ),
    );
    WidgetsBinding.instance
        .addPostFrameCallback((_) => start(context));
  }
  SharedPreferences prefs;
  void start(BuildContext){
    asyncFunc();
    //prefs.setBool("FUCK3", true);
  }
  asyncFunc() async { // Async func to handle Futures easier; or use Future.then
    prefs = await SharedPreferences.getInstance();
    //SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent,
    //systemNavigationBarColor: Colors.transparent,));
  }
  @override
  void dispose() {
    super.dispose();
  }
  void onDonePress() async {

    prefs.setBool("frun", true);
    
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }
  @override
  Widget build(BuildContext context) {

    return new IntroSlider(
      slides: this.slides,
      onDonePress: this.onDonePress,
      colorDot: Colors.yellow[700],
      colorSkipBtn: Colors.grey[200],
      styleNameDoneBtn: TextStyle(color:Colors.black),
      styleNameSkipBtn: TextStyle(color:Colors.black),
      colorDoneBtn: Colors.yellow[600],
      colorPrevBtn: Colors.grey,
      colorActiveDot: Colors.black,

    );
  }
}