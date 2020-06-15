//import 'dart:convert';
import 'dart:convert';
import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dio/dio.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
/////import 'package:firebase_messaging/firebase_messaging.dart';
//import 'package:firebase_analytics/firebase_analytics.dart';

//import 'package:firebase_remote_config/firebase_remote_config.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:platform_info/platform_info.dart';
import 'package:responsive_grid/responsive_grid.dart';
import './widgets/BrowsebyCategory.dart';

import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'animation/ScaleRoute.dart';
import 'globals.dart';
import 'pages/SignInPage.dart';
import 'utils/common/vars.dart';
import 'utils/utils.dart';

import 'utils/widgets.dart';
import 'widgets/BestOffersWidget.dart';
import 'widgets/BottomNavBarWidget.dart';
import 'widgets/SearchWidget.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;



class HomeScreen extends StatefulWidget {

  @override
  HomeScreenState createState() => new HomeScreenState();
}
class HomeScreenState extends State<HomeScreen> {
  SharedPreferences prefs;
  //FirebaseAnalytics analytics = FirebaseAnalytics();
  bool network = true;
  //============ CONFIG ===============
  bool parentlogin = true;
  bool guestlogin = true;
  //============ END ==================
  List<Map<String,String>> images=[];
  bool addformbool=false,deleteform=false,dialog_active=false,
      image_selected=false;
  Map<String,String> img = {};
  List<Widget> imageSliders = [];
  bool ismobile;

  asyncFunc(BuildContext) async {
    // Just create Platform() singleton object
  final Platform _platform = Platform();
  setState(() {
    ismobile = _platform.isMobile;
  });
  
  //print(ismobile);
  //UPDATE DELIVERY SYSTEM
  //
  
  //print("ENCODED: $encoded");
  //
  /*
  var m  = {
    "_etag": {
        "\$oid": "5d95ef77ab3cf85b199ed3b7"
    },
    "_id": "_meta",
    "descr": "just a test collection"
};*/
var m ={"joo":"kee"};
    String username = 'admin';
  String password = 'secret';
  String basicAuth =
      'Basic ' + base64Encode(utf8.encode('$username:$password'));
  print(basicAuth);
    String url = "http://localhost:8080/test/soap/louk";
    final response = await http.put(url,
    headers: {
      "Content-type": "application/json",
      "Access-Control-Allow-Origin":"*",
      //'authorization': basicAuth
      //HttpHeaders.wwwAuthenticateHeader: "No-Auth-Challenge",
      HttpHeaders.authorizationHeader: basicAuth,
      },
      body:json.encode(m)
      ).
      timeout(const Duration(seconds: 20)).catchError((err){
      print("${err}");}).then((value){
        //print("${value.body}");
      });
      /*
      Response response2;
      Dio dio = new Dio();
      
      dio.interceptors.add(InterceptorsWrapper(onRequest:
       (RequestOptions options) async {
        var customHeaders = {
          //'content-type': 'application/json',
          HttpHeaders.authorizationHeader: "Basic $encoded",
        };
        options.headers.addAll(customHeaders);
        return options;      
}));  
      //String url = "/alex";
      response2 = await dio.get(url).
      catchError((err){
        print("##### $err #########");
      });
      //print("############## ${response2.statusCode} ##########");
      //print("############## ${response2.data} ##########");*/

    load(this, true);
    //SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    prefs = await SharedPreferences.getInstance();
    
    
    
    load(this, false);

  }
  //final FirebaseMessaging _fcm = FirebaseMessaging();
  
  @override
  void initState() {
    
    super.initState();
    
    /*
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        
        final preferences = await StreamingSharedPreferences.instance;
        preferences.setString('lastnot', json.encode(message));

      },
      onLaunch: (Map<String, dynamic> message) async {},
      onResume: (Map<String, dynamic> message) async {},
    );
    _fcm.requestNotificationPermissions(  );
    _fcm.getToken().then((token){
      print("FCM_TOKEN:$token");
    });
    
    _fcm.subscribeToTopic("notifications").whenComplete((){
      print("notification subscription completed");
      print('in all');
    });*/

    WidgetsBinding.instance.addPostFrameCallback((_) => start(context));
  }
  onDidReceiveLocalNotification(){}
  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  }
  void start(BuildContext){
    asyncFunc(BuildContext);
    }
  @override
  void dispose() {super.dispose();}
  /*
  navigatorObservers: [
    FirebaseAnalyticsObserver(analytics: analytics),
   */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Colors.amber,
        elevation: 2,
        title: Row(children: <Widget>[
          logocustom(60, 50),
          Expanded(child:SearchWidget()),
          //SizedBox(width:MediaQuery. of(context). size. width/5)
        ],),
        brightness: Brightness.light,
        actions: <Widget>[
          if(kIsWeb && ismobile==false)loginbutton(Colors.blue),
          if(kIsWeb && ismobile==false)IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Color(0xFF3a3737),
              ),
              onPressed: () {
                //Navigator.push(context, ScaleRoute(page: SignInPage()));
                }),
          IconButton(
              icon: Icon(
                Icons.notifications_none,
                color: Color(0xFF3a3737),
              ),
              onPressed: () {
                //Navigator.push(context, ScaleRoute(page: SignInPage()));
                })
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 10,),
            fadeanimation(),
            //devmodex(),
            BestOffersWidget(),
            titler(this),
            Grid(),
            footer()
          ],
        ),
      ),
      bottomNavigationBar: (kIsWeb==false)?BottomNavBarWidget():
      (ismobile==true)?
      BottomNavBarWidget():Container(height:0),
    );
  }

  footer(){
    return Container(
      width: double.infinity,
      //height: 100,
      color: Colors.grey[900],
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top:10),
      child:ResponsiveGridList(
            scroll: false,
        desiredItemWidth: 300,
        minSpacing: 20,
        
        children:[
        Column(children:[
          Text("Foodle", style: TextStyle(color:Colors.white,
        fontSize: 25),),
        Text("© All rights are reserved",
        style: TextStyle(color:Colors.white),),
        ]),
        Row(children:[Icon(Icons.location_on, color: Colors.amber,),
        SizedBox(width:10), 
        Text("Kozhikode, Kerala, IN", style: cc,)
        ]),

        Row(children:[Icon(Icons.phone, color: Colors.amber,),
        SizedBox(width:10), 
        Text("+91 333 444950", style: cc,)
        ]),

        ResponsiveGridList(
            scroll: false,
            desiredItemWidth: 100,
        minSpacing: 5,
          children:[
        Text("Return Policy", style: link,),
        Text("Terms of Use", style: link,),
        Text("Privacy", style: link,),
        Text("Security", style: link,)
        ])
        ]));
  }
  var cc = TextStyle(color:Colors.white,
        fontSize: 18);
        var link = TextStyle(color:Colors.white54,
        fontSize: 15);
  devmodex(){return Container(
    color: Colors.black54,width: double.infinity,
    margin: EdgeInsets.all(5),
    padding: EdgeInsets.all(10),
    child: Text((ismobile==true)?
  "Running in mobile device":
  "Running in desktop device", style: TextStyle(
    color:Colors.white),),);
  }
}
