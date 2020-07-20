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
final mkey = en.Key.fromUtf8("qxDO7aSO5owUNEEBq42PbzGYToVxJOXJ");
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
       // timeInSecForIos: 1,
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
createagreement(user,car,terms){
 var htmlContent =
"""  
<!DOCTYPE html>
<html>
<head>
  <style>
page {
  background: white;
  display: block;
  margin: 0 auto;
  margin-bottom: 0.5cm;
}
page[size="A4"] {  
  width: 21cm;
  height: 29.7cm; 
}
page[size="A4"][layout="landscape"] {
  width: 29.7cm;
  height: 27cm;  
}
page[size="A3"] {
  width: 29.7cm;
  height: 42cm;
}
page[size="A3"][layout="landscape"] {
  width: 42cm;
  height: 29.7cm;  
}
page[size="A5"] {
  width: 14.8cm;
  height: 21cm;
}
page[size="A5"][layout="landscape"] {
  width: 21cm;
  height: 14.8cm;  
}
@media print {
  body, page {
    margin: 0;
    box-shadow: 0;
  }
}
  table, th, td {
    border: 1px solid black;
    border-collapse: collapse;
  }
  th, td, p {
    padding: 5px;
    text-align: left;
  }
  h1,h4,h6,h5{
padding:0px;
margin:0px;
}
th h5{
  margin-left:3px;
  margin-bottom: 10px;
  margin-top:10px;
}
  </style>
</head>
  <body>
    <page size="A4">
   <div style="text-align:right"><h1>Compass Rent A Car</h1>
<h4 style="margin-right:25px;padding:0px">D Ring Road,Near Commercial Bank</h4><h4 style="margin-right:183px">Tel : 33593275</h4>
<h4 style="margin-right:58px;padding:0px">Email:planning2022@gmail.com</h4>
</div>
<hr style="border:solid black 2px ">
<h5 style="display:inline">DATE:</h5> <h5 style="display:inline;margin-left:390px;"><bold>AGREEMENT NO:</bold></h5>

    <table style="width:100%;margin-top:10px">
      <tr>
        <th colspan="1">Customer Details
          <h5> Nationality :</h5>
          <h5>QID NO :${user['QIDNO']}</h5>
          <h5>Expiry Date :${user['QIDexpiry']} </h5>
          <h5>License NO :${user['licenseno']}</h5>
          <h5>Expiry Date :${user['licenseexpiry']}</h5>
          <h5>Load Location :</h5>
        </th>
        <th colspan="2" >    
        <h5> Residency Address :${user['homeaddress']}</h5>
        <h5>Residency Tel :${user['landline']}</h5>
        <h5>Working Address :${user['officeaddress']}</h5>
        <h5>Tel :${user['number']}</h5>
        <h5>Mobile :${user['number']}</h5>
        <h5>Emergency Contact :</h5></th>
      </tr>
      <tr> 
      <th>
        <h5> Add Driver :</h5>
        <h5> Address :</h5>


      </th>
      <th colspan="2">
        <h5> License No :</h5>
        <h5> Mobile No :</h5>
      </th>
      </tr>
      <tr>
        <th>
          <h5> Vechile No :${car['number']}</h5>
          <h5> Type of Car :${car['make']}</h5>
          <h5> Colour :${car['colour']}</h5>
          <h5> Model :${car['model']}</h5>
          <h5> Contact Period :${convertdate(car['date'])}</h5>
          <h5> Rate  :${car['price']}</h5>


        </th><th>
          <h5> Date Out :</h5>
          <h5> Time Out :</h5>
          <h5> Km Out :</h5></th>
        <th>
        <h5> Date In :</h5>
        <h5> Time In :</h5>
        <h5> Km In :</h5>
        <h5 style="margin-top:45px"> Hire Sign :</h5>

        </th>
      </tr>
      <tr>
        <th colspan="3">
          <h4>Remarks</h4>
          <h5>Working Hours 8:00 to 13:00 & 16:00 to 21:00</h5>
          <h5>Vechile Should may not be return to Compass Rent A Car on Friday,Every Holidays </h5>
 <h5>Compass should not be responsible for any item in vechile,So please remove all private and personal belongings Prior to Leaving him vechile with us. </h5>
        </th></tr>
        <tr>
          <th colspan="3">
            <h4>Authorization</h4>
          <h5>I hereby authorize to compass rent a car company on cheque/cash/credit card of my hire cahrge,traffic offense,damage charge and any other cahrge etc. Relating to rental agreement during the hiring period and till the vechile is return to compass</h5>
          </th>
        </tr>
        <tr>
          <th colspan="3">
            <h5>I / we have read above mentioned terms and condition and agree to abide by them</h5>
          </th>
        </tr>
    </table>
    <br>
    <br>
    <p style="display: inline;">.....................................</p>
    <p style="margin-left:450px;display: inline;">.....................................</p>
    <h6 style="margin-left:5px;margin-top: 8px;display: inline;">Rental Agent Sign</h6>
    <h6 style="margin-left:540px;margin-top: 8px;display: inline;">Hirer Sign</h6>
    </page>
    <page size="A4">
      <table style="width:100%;margin-top:70px;"><tr>
        <th><h4>Terms Of Car Rental Agreement</h4>
        <h5>$terms</h5>
      <h4>Signature .....................................</h4>  
      </th>
      </tr></table>
      
    </page>
  </body>
</html>
""";
return htmlContent;
}
convertdate(date)=>DateTime.fromMillisecondsSinceEpoch(int.parse(date.toString())).toString().split(' ')[0];
getsetyle(){
  return """  
<!DOCTYPE html>
<html>
<head>
  <style>
page {
  background: white;
  display: block;
  margin: 0 auto;
  margin-bottom: 0.5cm;
}
page[size="A4"] {  
  width: 21cm;
  height: 29.7cm; 
}
page[size="A4"][layout="landscape"] {
  width: 29.7cm;
  height: 27cm;  
}
page[size="A3"] {
  width: 29.7cm;
  height: 42cm;
}
page[size="A3"][layout="landscape"] {
  width: 42cm;
  height: 29.7cm;  
}
page[size="A5"] {
  width: 14.8cm;
  height: 21cm;
}
page[size="A5"][layout="landscape"] {
  width: 21cm;
  height: 14.8cm;  
}
@media print {
  body, page {
    margin: 0;
    box-shadow: 0;
  }
}
  table, th, td {
    border: 1px solid black;
    border-collapse: collapse;
  }
  th, td, p {
    padding: 5px;
    text-align: left;
  }
  h1,h4,h6,h5{
padding:0px;
margin:0px;
}
th h5{
  margin-left:3px;
  margin-bottom: 10px;
  margin-top:10px;
}
  </style>
</head>
""";
}

uptoremarks (user,car,terms){
  return """<body>
    <page size="A4">
   <div style="text-align:right"><h1>Compass Rent A Car</h1>
<h4 style="margin-right:25px;padding:0px">D Ring Road,Near Commercial Bank</h4><h4 style="margin-right:183px">Tel : 33593275</h4>
<h4 style="margin-right:58px;padding:0px">Email:planning2022@gmail.com</h4>
</div>
<hr style="border:solid black 2px ">
<h5 style="display:inline">DATE:</h5> <h5 style="display:inline;margin-left:390px;"><bold>AGREEMENT NO:</bold></h5>

    <table style="width:100%;margin-top:10px">
      <tr>
        <th colspan="1">Customer Details
          <h5> Nationality :</h5>
          <h5>QID NO :${user['QIDNO']}</h5>
          <h5>Expiry Date :${user['QIDexpiry']} </h5>
          <h5>License NO :${user['licenseno']}</h5>
          <h5>Expiry Date :${user['licenseexpiry']}</h5>
          <h5>Load Location :</h5>
        </th>
        <th colspan="2" >    
        <h5> Residency Address :${user['homeaddress']}</h5>
        <h5>Residency Tel :${user['landline']}</h5>
        <h5>Working Address :${user['officeaddress']}</h5>
        <h5>Tel :${user['number']}</h5>
        <h5>Mobile :${user['number']}</h5>
        <h5>Emergency Contact :</h5></th>
      </tr>
      <tr> 
      <th>
        <h5> Add Driver :</h5>
        <h5> Address :</h5>


      </th>
      <th colspan="2">
        <h5> License No :</h5>
        <h5> Mobile No :</h5>
      </th>
      </tr>
      <tr>
        <th>
          <h5> Vechile No :${car['number']}</h5>
          <h5> Type of Car :${car['make']}</h5>
          <h5> Colour :${car['colour']}</h5>
          <h5> Model :${car['model']}</h5>
          <h5> Contact Period :${convertdate(car['date'])}</h5>
          <h5> Rate  :${car['price']}</h5>


        </th><th>
          <h5> Date Out :</h5>
          <h5> Time Out :</h5>
          <h5> Km Out :</h5></th>
        <th>
        <h5> Date In :</h5>
        <h5> Time In :</h5>
        <h5> Km In :</h5>
        <h5 style="margin-top:45px"> Hire Sign :</h5>

        </th>
      </tr>
      <tr>
  """;
}
afterremarks(user,car,terms){
  return  """ <th colspan="3">
          <h4>Remarks</h4>
          <h5>Working Hours 8:00 to 13:00 & 16:00 to 21:00</h5>
          <h5>Vechile Should may not be return to Compass Rent A Car on Friday,Every Holidays </h5>
 <h5>Compass should not be responsible for any item in vechile,So please remove all private and personal belongings Prior to Leaving him vechile with us. </h5>
        </th></tr>
        <tr>
          <th colspan="3">
            <h4>Authorization</h4>
          <h5>I hereby authorize to compass rent a car company on cheque/cash/credit card of my hire cahrge,traffic offense,damage charge and any other cahrge etc. Relating to rental agreement during the hiring period and till the vechile is return to compass</h5>
          </th>
        </tr>
        <tr>
          <th colspan="3">
            <h5>I / we have read above mentioned terms and condition and agree to abide by them</h5>
          </th>
        </tr>
    </table>
    <br>
    <br>
    <p style="display: inline;">.....................................</p>
    <p style="margin-left:450px;display: inline;">.....................................</p>
    <h6 style="margin-left:5px;margin-top: 8px;display: inline;">Rental Agent Sign</h6>
    <h6 style="margin-left:540px;margin-top: 8px;display: inline;">Hirer Sign</h6>
    </page>
    <page size="A4">
      <table style="width:100%;margin-top:70px;"><tr>
        <th><h4>Terms Of Car Rental Agreement</h4>
        <h5>$terms</h5>
      <h4>Signature .....................................</h4>  
      </th>
      </tr></table>
      
    </page>
  </body>
</html>
""";
}