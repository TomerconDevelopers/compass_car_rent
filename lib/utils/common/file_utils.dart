import 'dart:convert';
import 'dart:io';

import 'package:file_picker_web/file_picker_web.dart';
import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as p;
import 'package:random_string/random_string.dart';
import 'package:http/http.dart' as http;
import '../../globals.dart';
import '../utils.dart' as ut;
import 'vars.dart';

var file;bool dialog_active;

Future pickfile(State m) async {
    // Will return a File object directly from the selected file
    var temp;
    temp =  await FilePicker.getFile();
    print("temp $temp");
    return temp;
  }
Widget filetext() {
    return Row(
      children: <Widget>[
        Column(
          children: <Widget>[
            Icon(Icons.insert_drive_file),
            Text(
            "${filesize(file.size)}",
              style: TextStyle(fontSize: 10),
            ),
          ],
        ),

        Expanded(
          child:Text("${file.name}"),//Text(p.basename(file)),
        ),

        //fname = p.basename(file.path);
        //fext = p.extension(file.path);
      ],
    );
  }
  
  Widget filepicker(bool editmode,State m) {
    return InkWell(
      onTap: () async {
        if (editmode) {
          ut.showtoast(
              "You cant change file. Delete current file then Upload new files",
              Colors.red);
        } else {
          var temp = await pickfile(m);
          m.setState(() {
            file = temp;
          });
        }
      },
      child: Container(
        padding: EdgeInsets.all(10),
        color: Colors.grey[200],
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 9, // 70%
              child: Container(
                  color: Colors.grey[200],
                  child: (!editmode)
                      ? (file == null) ? Text('No file selected.') : filetext()
                      : Text("You can't change file")),
            ),
            if (file != null)
              Expanded(
                flex: 1, // 30%
                child: InkWell(
                    child: Container(
                        child: Icon(
                      Icons.cancel,
                      color: Colors.grey,
                    )),
                    onTap: () {
                      m.setState(() {
                        file = null;
                        //FIELD_VALUE['file'] = null;
                      });
                    }),
              ),
          ],
        ),
      ),
    );
  }
  Future<String> uploadfile(var file,State m) async {
    m.setState(() {loadingtext="Uploading file ...";});
    
  ut.load(m,true);
  //String extension = 'png';
  String filename = file.name.toString();
  final String fileName = randomNumeric(5)+filename;
  final String phpEndPoint = '$imageurl/files/upload.php';
  String base64Image = base64Encode(file.readAsBytesSync());
  await http.post(phpEndPoint, body: {
    "image": base64Image,
    "name": fileName,
  }).then((res) {
    ut.load(m,false);
    FocusScope.of(m.context).requestFocus(new FocusNode());
  }).catchError((err) {
    print(err);ut.load(m,false);
    FocusScope.of(m.context).requestFocus(new FocusNode());
  });
  m.setState(() {loadingtext="loading ...";});
  return "$imageurl/files/$fileName";
}
//=============== file ====================
  Widget open(String url, String id, String filepath, String filename) =>
      InkWell(
        child: ut.roundicon(
            Icons.remove_red_eye, Colors.black, Colors.grey[200], 20, 5),
        onTap: () {
          //OPEN FILE FROM PHONE STORAGE
          OpenFile.open(filepath).then((status) {
            print("status: $status");
            if (status != "done") ut.showtoast(status, Colors.black);
          });
        },
      );

  