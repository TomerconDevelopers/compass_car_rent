
import 'package:cached_network_image/cached_network_image.dart';

import 'utils/widgets.dart';
import 'package:flutter/material.dart';
import 'utils/utils.dart' as ut;

import 'globals.dart';
import 'utils/styles.dart';

class CarDetails extends StatefulWidget {
  //final String text,name;
  //Base({Key key, @required this.text,@required this.name}) : super(key: key);
  @override
  Map data;
  CarDetails({this.data});
  //BaseState createState() => new BaseState(text,name);
  CarDetailsState createState() => new CarDetailsState(data: data);
}
class CarDetailsState extends State<CarDetails> {
Map data;
CarDetailsState({this.data});
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
convertdate(date){
if(date.toString() != "null"){   return DateTime.fromMillisecondsSinceEpoch(int.parse(date.toString())).toString().split(' ')[0];}else{return "Invalid Format";}
  }  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car Details',
      theme: maintheme(),
      home: Scaffold(
          appBar: AppBar(
            title: Text('Car Details'),
          ),
          body: Container(
            width: double.infinity,
            decoration: bg(),
            child:
                ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10.0),
                      padding: EdgeInsets.all(15.0),
                      width: double.infinity,
                      
                      decoration:BoxDecoration(
                        color: Colors.amberAccent,),
                        child: Column(
                          children:[
                         data['photo'] != null ?    Container(
                              height: 300,
                              child: CachedNetworkImage(imageUrl: data["photo"],fit: BoxFit.fill,)) : Container(),
                          Wrap(

                            children: [

                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: roundedtext(" Model :${data["model"]}", Colors.white60, Colors.black, 5.0, 16.0),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: roundedtext(" Price :${data["price"]}", Colors.white60, Colors.black, 5.0, 16.0),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: roundedtext(" Make :${data["make"]}", Colors.white60,Colors.black, 5, 16.0),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: roundedtext(" Number :${data["number"]}", Colors.white60,Colors.black, 5, 16.0),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: roundedtext(" Colour :${data["colour"]}", Colors.white60,Colors.black, 5, 16.0),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: roundedtext(" Manufacture Year :${data["manufactureyear"]}", Colors.white60, Colors.black, 5, 16.0),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: roundedtext(" Isthimara Date :${ convertdate(data["isthimaradate"])}", Colors.white60, Colors.black, 5, 16.0),
                              ),

                              //roundedtext(" Date :${DateTime.fromMillisecondsSinceEpoch(int.parse(data['date'].toString())).toString().split(' ')[0]}", Colors.white60, Colors.black, 5, 16.0),
                              Padding(padding: EdgeInsets.all(5),child: roundedtext(" Expiry year :${data["expiryyear"]}", Colors.white60, Colors.black, 5, 16.0)),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: roundedtext(" Purchase Date :${DateTime.fromMillisecondsSinceEpoch(int.parse(data['purchasedate'].toString())).toString().split(' ')[0]}}", Colors.white60, Colors.black, 5, 16.0),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: roundedtext(" ID :${data["_id"]}", Colors.white60, Colors.black, 5, 16.0),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: roundedtext("Partnership Details :${data["partnershipdetails"]}", Colors.white60, Colors.black, 5, 16.0),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: roundedtext(" last fuel and oil change kms :${data["last_fuel_and_oil_change_kms"]}", Colors.white60, Colors.black, 5, 16.0),
                              ),

                              //roundedtext(" Date :${DateTime.fromMillisecondsSinceEpoch(int.parse(data['date'].toString())).toString().split(' ')[0]}", Colors.white60, Colors.black, 5, 16.0),
                              Padding(padding: EdgeInsets.all(5),child: roundedtext(" Oilchange Date :${convertdate(data["oilchange_date"])}", Colors.white60, Colors.black, 5, 16.0)),
                              Padding(padding: EdgeInsets.all(5),child: roundedtext(" Oilchange Cost :${data["oilchange_cost"]}", Colors.white60, Colors.black, 5, 16.0)),
                              Padding(padding: EdgeInsets.all(5),child: roundedtext(" Nextdue Km :${data["nextdue_km"]}", Colors.white60, Colors.black, 5, 16.0)),
                              Padding(padding: EdgeInsets.all(5),child: roundedtext(" Tentative Date:${convertdate(data["tentative_date"])}", Colors.white60, Colors.black, 5, 16.0)),
                              Padding(padding: EdgeInsets.all(5),child: roundedtext("Repair Details:${data["repaidetails"]}", Colors.white60, Colors.black, 5, 16.0)),
                              Padding(padding: EdgeInsets.all(5),child: roundedtext(" Repair cost :${data["repaicost"]}", Colors.white60, Colors.black, 5, 16.0)),
                              Padding(padding: EdgeInsets.all(5),child: roundedtext(" Washing :${data["washing"]}", Colors.white60, Colors.black, 5, 16.0)),
                              Padding(padding: EdgeInsets.all(5),child: roundedtext(" Miscellanous :${data["miscellanous"]}", Colors.white60, Colors.black, 5, 16.0)),
                              Padding(padding: EdgeInsets.all(5),child: roundedtext(" Rent User :${data["rentuser"]}", Colors.white60, Colors.black, 5, 16.0)),
                              Padding(padding: EdgeInsets.all(5),child: roundedtext(" Date Return :${convertdate(data["date"])}", Colors.white60, Colors.black, 5, 16.0)),
                            
                            ],
                          ),
                          SizedBox(height:10),
                          ]
                        ),
                      )
                    ]  )
                  ,
                )
          
      ),
    );
  }
}
