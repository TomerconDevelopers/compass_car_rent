import 'package:cached_network_image/cached_network_image.dart';
import 'package:encrypt/encrypt.dart' as en;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gradient_text/gradient_text.dart';
//import 'package:koukicons/customerSupport.dart';
//import 'package:koukicons/manager.dart';
//import 'package:store_redirect/store_redirect.dart';
import '../globals.dart';
import 'common/vars.dart';



RoundedRectangleBorder roundedborder(double val){
  return new RoundedRectangleBorder(
    borderRadius: new BorderRadius.circular(val),
  );
}
final mkey = en.Key.fromUtf8(key);
final iv = en.IV.fromLength(16);
final encrypter = en.Encrypter(en.AES(mkey));
String encrypt(String txt){
  print(iv.base64);
  final encrypted = encrypter.encrypt(txt, iv: iv);
  return encrypted.base64;
}
void showtoast(String text, Color col) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: col,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
  
String decrypt(txt){
  print(iv.base64);
  final decrypted = encrypter.decrypt(en.Encrypted.fromBase64(txt), iv: iv);
  return decrypted;
}
  void load(State m,bool val){
    if(val){ m.setState(() {loading = true;});}
    else{m.setState(() {loading = false;});}
  }
  
Widget checkbox(String title,String key,var map,State thism){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Text(title),
        Checkbox(
          checkColor: Colors.white,
          activeColor: Colors.blue,
            value: map[key],
            onChanged: (bool value) {
                thism.setState(() {
                    map[key] = value;
                });
            },
        ),
    ],
);
}


  Widget circleicon(var icn,Color icc,Color bg,double size){
    return Container(
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                color: bg,
                shape: BoxShape.circle,
              ),
              child: Icon(icn,size:size,color: icc),
            );
  }
  
  datediffer(DateTime d1,DateTime d2){
    //var lastsyn = new DateTime.fromMillisecondsSinceEpoch(lastsync);
          var diff = d2.difference(d1);
          var daysleft = diff.inDays;
          var hoursleft = diff.inHours - (diff.inDays*24);
          var minutesleft = diff.inMinutes - (diff.inHours*60);
          Map<dynamic,dynamic> p = new Map();
          p["d"] = daysleft;p["h"] = hoursleft;p["m"] = minutesleft;
          return p;
  }
  Widget header(var icon,String title){
    return Container(width: double.infinity,
                        padding: EdgeInsets.all(10),
                          color: Colors.grey[100],
                          child:Row(children: <Widget>[
                            Icon(icon),
                            Padding(padding: EdgeInsets.only(left: 10),
                              child:Text(title),)
                          ],)
                          );
  }
  

  bs(double r) => BoxShadow(color: Colors.grey,blurRadius: r);
  mycard(var col,var radius,var shadow_depth) => 
        BoxDecoration(  
            color: col,
            borderRadius: BorderRadius.circular(radius),
            boxShadow: [bs(shadow_depth)]);
  

roundicon(var icn,Color icc,Color bg,double size,double pad)=>
    Container(
      margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(pad),
              decoration: BoxDecoration(
                color: bg,
                shape: BoxShape.circle,
              ),
              child: Icon(icn,size:size,color: icc),
            );

String listtostring(List li){
  String z="";
  for(var i in li){
    (i!=li.last)?z = z + i+",":z = z + i;
  }
  //print("$z");
  return z;
}

Widget gradienttext(var txt)=>GradientText("$txt",
    gradient: LinearGradient(
        colors: [Colors.pink, Colors.deepOrange, Colors.amber]),
    style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700),
    textAlign: TextAlign.center);
Widget profileitem(var icon,Color cc,var txt,Color tcolor){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Icon(icon, color: cc,),SizedBox(width: 5,),Text(txt,
      style: TextStyle(color: tcolor),)
    ],
  );
}

profpic(double size)=>
    (insinfo!=null&&insinfo.isNotEmpty)?(userinfo['photourl']!=null&&userinfo['photourl']!="NULL"&&userinfo['photourl']!="")?
    ClipRRect(borderRadius: BorderRadius.circular(10000.0),
      child: CachedNetworkImage(
        placeholder: (context, imgurl) => CircularProgressIndicator(),
        imageUrl:userinfo['photourl'],
        fit: BoxFit.fill,
        width: size,height: size,),):
    Icon(Icons.person):Icon(Icons.person);

maingradient()=>LinearGradient(
begin: Alignment.topLeft,
end: Alignment.bottomRight,
colors: [Colors.red, Colors.yellow]);

hidekeyboard(){
  SystemChannels.textInput.invokeMethod('TextInput.hide');
}
unfocus(State m){
  FocusScopeNode currentFocus = FocusScope.of(m.context);
  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}
