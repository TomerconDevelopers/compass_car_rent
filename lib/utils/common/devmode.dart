/*
//=========================== GET DEVICE INFO AND SHAREDPREFS ==================
  import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';

import '../../globals.dart';
import '../../main.dart';
import 'vars.dart';

devbutton(State m){
    return IconButton(onPressed: (){
      getinfo();
     m.setState(() {devmode = !devmode;});
    },
      icon: Icon(Icons.android),);
  }
  var androidInfo;
  getinfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    androidInfo = await deviceInfo.androidInfo;
    AndroidDeviceInfo dc = await deviceInfo.androidInfo;
    print('Running on ${androidInfo.model}');  // e.g. "Moto G (4)"
  }
  devmodescreen(State m){
    return (devmode)?
    Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(5),
      color: Color(0x99000000),
      child: 
      SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
          Text('Developer Mode',style: TextStyle(color: Colors.white,
          fontWeight: FontWeight.bold ),),
          Divider(color: Colors.white,),
          if(androidInfo!=null)Text('Running on ${androidInfo.model}',
          style: TextStyle(color: Colors.white),),
          Divider(color: Colors.white,),
          if(androidInfo!=null)Text('Device id:  ${androidInfo.androidId}',
          style: TextStyle(color: Colors.white),),
          Divider(color: Colors.white,),
          if(androidInfo!=null)Text('Device details:  ${androidInfo.display}',
          style: TextStyle(color: Colors.white),),
          Divider(color: Colors.white,),
          if(androidInfo!=null)Text('Product:  ${androidInfo.product}',
          style: TextStyle(color: Colors.white),),
           Divider(color: Colors.white,),
           Text('Shared Preference',style: TextStyle(color: Colors.white,
          fontWeight: FontWeight.bold ),),
            Divider(color: Colors.white,),
          speditor()
        ],),
      )
    )
    
    :
    Text('');
  }
  Widget speditor(){
    return new ListView.builder(
  itemCount: prefs.getKeys().length,
  physics: const NeverScrollableScrollPhysics(),
  shrinkWrap: true,
  itemBuilder: (BuildContext context, int index) {
    String key = prefs.getKeys().elementAt(index);
    return new Column(
      children: <Widget>[
        new ListTile(
          //contentPadding: EdgeInsets.all(0),
          leading: CircleAvatar(child: Text("${index+1}"),radius: 15,),
          trailing: IconButton(onPressed: (){
              //DElete sharedprefs
              prefs.remove(key);
              getinfo();
          },
          icon: Icon(Icons.delete,color: Colors.red[400]),),
          title: new Text("$key",style: TextStyle(color: Colors.white),),
          onTap: (){
            
          },
          subtitle: new Text("${prefs.get(key)}",style: TextStyle(color: Colors.amber),),
        ),
        new Divider(
          height: 0.0,color: Colors.black,
        ),
      ],
    );
  },
);
  }
  */