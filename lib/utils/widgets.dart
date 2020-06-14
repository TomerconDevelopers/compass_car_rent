import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:store_redirect/store_redirect.dart';


import '../globals.dart';
import 'common/vars.dart';
import 'styles.dart';
import '../utils/utils.dart';

Widget fadeanimation()=>SizedBox(
  //width: 250.0,
  child: FadeAnimatedTextKit(
    isRepeatingAnimation: true,
    repeatForever: true,
    onTap: () {
        print("Tap Event");
      },
    text: [
      "Welcome to foodle",
      "Best offers here",
      "Instant delivery"
    ],
    textStyle: TextStyle(
        fontSize: 32.0, 
        color: Colors.grey,
        fontWeight: FontWeight.w400,
    ),
    textAlign: TextAlign.start,
    alignment: AlignmentDirectional.topStart // or Alignment.topLeft
    ),
    );

Widget appbarbutton(String txt,{Color col,txtcol,IconData icon})=>
  Row(children:[
Container(
    padding: EdgeInsets.symmetric(vertical:2, horizontal: 5),
    //margin: EdgeInsets.all(15),
    decoration: rounded2((col!=null)?col:Colors.white70, false, 100),
    child:
  Row(children:[
 Text(txt,textAlign: TextAlign.center,
style: TextStyle(color: (txtcol!=null)?txtcol:Colors.black),
),
    if(icon!=null)SizedBox(width:5),
    if(icon!=null)Icon(icon,color: (txtcol!=null)?txtcol:Colors.black,)
  ]))
  ]);
  Widget loader(){
    return 
        Align(
          alignment: Alignment.center,
          child: 
          
              Container(
                width: double.infinity,
                height: double.infinity,
            //decoration: bg(),
            child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              logo(),
              new CircularProgressIndicator(),
              SizedBox(height: 10),
              Text((loadingtext!=null)?loadingtext:"Uploading image ...",
            style: TextStyle(fontSize: 20,color: Colors.black,
            fontWeight: FontWeight.w500)),
              
              //ColorLoader3(radius: 15,dotRadius: 6, )
            ],
          ),)   
    );
  }
  Widget loginbutton(Color col)=>Container(
    margin: EdgeInsets.all(10),
    padding: EdgeInsets.only(right:10),
    decoration: rounded(col, 40),
    child: Row(children:[
      roundicon(Icons.person, col, Colors.white, 20, 2),

      Text("Login", style: TextStyle(color:Colors.white),)
    ]),);
  Widget IcoButton2(BuildContext context,String name,var icn,Color icc){
    return Container(
      margin: EdgeInsets.all(0),
      padding: EdgeInsets.all(0),

       child:Container(
         padding: EdgeInsets.all(5),
         decoration: rounded(Colors.amber, 30),
         child: Icon(icn,size:30,color: Colors.white),
       ),
    );
  }
  networkerror(){
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.wifi,size: 40,),
          Text('NETWORK ERROR',),
          FlatButton(child: Text('RETRY',style: TextStyle(color: Colors.white),),
          onPressed: (){},
          color: Colors.orange,
          )
          
        ],
      ),
    );
  }
  Widget empty_server(String txt){
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.info,size: 50,color: Colors.white,),
          Text('$txt',textAlign:TextAlign.center,style: TextStyle(fontSize: 20,
          fontWeight: FontWeight.w600,color: Colors.blue[800]),)
        ],

      )
      );
  }
  
  image(String url){
      return ClipRRect(borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          placeholder: (context, imgurl) => CircularProgressIndicator(),
          imageUrl:url,
          fit: BoxFit.fill,
        ),);}
  Widget blanktextfield(String txt,var controller,int keyboard_type,int maxlines){
    return new Container(
      width: 120,
    child:TextFormField(
      maxLines: maxlines,
      controller: controller,
      decoration: new InputDecoration(
        labelText: "Enter "+txt,
        contentPadding: EdgeInsets.all(0.0),
        fillColor: Colors.white,
        
        //fillColor: Colors.green
      ),
      onChanged: (val){
        
      },
      inputFormatters: (keyboard_type==1)?[WhitelistingTextInputFormatter.digitsOnly]:[],
      keyboardType: (keyboard_type==1)?TextInputType.number:TextInputType.text,
      style: new TextStyle(
        color: Colors.black,
        fontFamily: "Poppins",
      ),
    ));
  }
  Widget logo(){
    return new Image.asset(
                'assets/images/logo.png',
                width: logowidth,
                height: logoheight,
                fit: BoxFit.cover,
              );
  }
Widget logocustom(double width,double height){
  return new Image.asset(
    'assets/images/logo.png',
    width: width,
    height: height,
    fit: BoxFit.cover,
  );
}
  updatewidget(){
  return Container(
    width: double.infinity,
    height: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 10,),
        if(updatecode==1)Icon(Icons.person),
        if(updatecode==0)CircularProgressIndicator(),
        roundedtext(updatetxt, Colors.white54, Colors.black,5.0,15),
        SizedBox(height: 10,),
        if(updatecode==1)FlatButton(child: Text('UPDATE',style: TextStyle(color: Colors.white),),
          onPressed: (){
          //GOTO google play
          /*
            StoreRedirect.redirect(androidAppId: packagename,
                iOSAppId: "585027354");*/
          },
          color: Colors.orange,
        )
      ],
    ),
  );
}
  BoxDecoration rounded(var col,double r){
    return BoxDecoration(
      color: col,
        borderRadius: BorderRadius.circular(r),
        border: Border.all(
            color: Colors.transparent, style: BorderStyle.solid,
             width: 0.80),
      );
  }
  Widget item(var icn,Color icn_col,String title,String value){
      return Padding(padding: const EdgeInsets.all(5.0),
            child:
            Row(children: <Widget>[
              Icon(icn,color: icn_col,size: 20),
              Padding(padding: EdgeInsets.only(left: 5),
              child: Text(title,style: TextStyle(fontSize: 14,color: Colors.grey[700]
            ,fontStyle: FontStyle.normal,
            )),), 
            Expanded(child: Text(value,style: TextStyle(fontSize: 14,color: Colors.grey[900]
            ,fontStyle: FontStyle.normal,
            )))
            ],)
             );
    }
Widget roundedtext(String txt,Color bgcol,Color txtcol, double pad, fontsize){
  return Container(
    padding: EdgeInsets.all(pad),
    margin: EdgeInsets.all(0),
    decoration: rounded(bgcol,40.0),
    child: Text(txt,style: TextStyle(color: txtcol,fontSize: fontsize),),
  );
}
  Widget roundedinfo(var icn,String txt,Color bgcol,Color txtcol){
      return Container(
        padding: EdgeInsets.all(1),
        margin: EdgeInsets.all(1),
        decoration: rounded(bgcol,40.0),
        child: Row(children: <Widget>[
          Icon(icn,color: txtcol,),
          Text(txt,style: TextStyle(color: txtcol,fontSize: 12),),
        ],)
        
      );
    }
  Widget curvedtextfield(String txt,int keyboard_type){
    return new Padding(
        padding:  const EdgeInsets.all(10.0),
    child:TextFormField(
      decoration: new InputDecoration(
        labelText: "Enter "+txt,
        contentPadding: EdgeInsets.all(5.0),
        fillColor: Colors.white,
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(40.0),
          borderSide: new BorderSide(color: Colors.blue),
        ),
        //fillColor: Colors.green
      ),
      onChanged: (val){ },
      inputFormatters: (keyboard_type==1)?[WhitelistingTextInputFormatter.digitsOnly]:[],
      keyboardType: (keyboard_type==1)?TextInputType.number:TextInputType.text,
      style: new TextStyle(
        fontFamily: "Poppins",
      ),
    ));
  }