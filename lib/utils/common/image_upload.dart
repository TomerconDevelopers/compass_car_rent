import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:koukicons/camera2.dart';
import 'package:koukicons/gallery.dart';
import 'package:path/path.dart' as p;
import 'package:random_string/random_string.dart';
import '../../globals.dart';
import '../utils.dart' as ut;
import '../widgets.dart';
import 'package:http/http.dart' as http;

import 'vars.dart';


File imgFile;
bool dialog_active;

Widget profilephotopicker(State m){
  return InkWell(
    onTap: (){
      showimageselector(m,50);
      dialog_active=true;
      },
    child:
    Container(
      padding: EdgeInsets.all(10),
      color: Colors.grey[200],
      child:Row(
        children: <Widget>[
          Expanded(
            flex: 5, // 70%
            child: Container(color: Colors.grey[200],
                child:
                (imgFile == null)
                    ? Text('No image selected.')
                    : Image.file(imgFile,width: 200,height: 100,)
            ),
          ),
          Expanded(
            flex: 1, // 30%
            child: Container(child: Icon(Icons.add_a_photo,color: Colors.purple,)),
          ),
          if(imgFile!=null)Expanded(
            flex: 1, // 30%
            child: InkWell(child:Container(child:
            Icon(Icons.cancel,color: Colors.grey,)),
                onTap: (){m.setState(() {imgFile=null;});}
            ),
          ),
        ],
      ),),);
}
Future<String> uploadimage(File file,State m) async {
  ut.load(m,true);
  m.setState(() {loadingtext="Uploading image ...";});
  //String extension = 'png';
  String filename = file.path.split("/").last;
  final String fileName = randomNumeric(5)+filename;
  final String phpEndPoint = '$serurl/pics/upload.php';
  String base64Image = base64Encode(file.readAsBytesSync());
  await http.post(phpEndPoint, body: {
    "image": base64Image,
    "name": fileName,
  }).then((res) {
    ut.load(m,false);
    FocusScope.of(m.context).requestFocus(new FocusNode());
    print(res.statusCode);
    print("****** ${res.body}");
    //FIELD_VALUE["photo"] = "$serurl/pics/$fileName";
    //================ IMPORTANT ================
    //place final post here


  }).catchError((err) {
    print(err);ut.load(m,false);
    FocusScope.of(m.context).requestFocus(new FocusNode());
  });
  m.setState(() {loadingtext="loading ...";});
  return "$serurl/pics/$fileName";
}
getImage(State m,int type, int quality) async {
  var image = await ImagePicker.pickImage(
      source: (type==0)?ImageSource.camera:ImageSource.gallery);
  FocusScope.of(m.context).requestFocus(new FocusNode());
  if(image!=null) {
    //ut.showtoast(p.extension(image.path), Colors.orange);
    File compressedFile = await FlutterNativeImage.compressImage(image.path,
        quality: quality, percentage: 80);
    m.setState(() {
     imgFile = compressedFile;
    });
      Navigator.of(m.context, rootNavigator: true).pop(imgFile);
      //Navigator.pop(m.context);
      dialog_active = false;
      //ut.showtoast(imgFile.path, Colors.black);
      print(imgFile);

  }
}

showimageselector(State m,int quality) async {
  //type=0 , delete post
  return showDialog(
      context: m.context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[100],
          contentPadding: EdgeInsets.all(10),
          titlePadding: EdgeInsets.all(0),
          title:
          Container(
              color: Colors.grey[100],
              child:
              Row(children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(left: 20),
                    child:Text("",
                        style: TextStyle(color: Colors.white))),
                Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child:IconButton(icon: Icon(Icons.cancel,
                        color: Colors.grey[700],),
                        onPressed: (){
                          Navigator.of(context).pop();
                          dialog_active=false;
                        },),
                    ))
              ],)),
          content: Container(
              width: double.maxFinite,
              padding: EdgeInsets.only(bottom:30),
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  iconitem(m, "Gallery", KoukiconsGallery(height: 60,),1,quality),
                  iconitem(m, "Camera", KoukiconsCamera2(),0,quality)
                ],)
          ),
        );
      });
}
Widget iconitem(State m,String txt, Widget icon,type, int quality){
  return InkWell(child:
  Column(
      mainAxisSize: MainAxisSize.min,
      children:[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: 80,width: 80,
          decoration: rounded(Colors.grey[200], 400),
          child: icon,),
        Text("$txt")
      ]),
    onTap: (){var file = getImage(m, type, quality).then((val) {

    print("iconitem $val");
    });
    return "x";},);
}
image(String url)=>
    ClipRRect(borderRadius: BorderRadius.circular(10),
      child: CachedNetworkImage(
        placeholder: (context, imgurl) => CircularProgressIndicator(),
        imageUrl:url,
        fit: BoxFit.fill,
      ),);