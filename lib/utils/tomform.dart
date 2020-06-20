import 'dart:convert';
import 'dart:io';
import 'package:filesize/filesize.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:random_string/random_string.dart';
import '../globals.dart';
import '../utils/utils.dart' as ut;
import 'package:http/http.dart' as http;



import 'package:strings/strings.dart';


import 'common/file_utils.dart';
import 'common/image_upload.dart';
import 'common/strings.dart';
import 'common/vars.dart';
import 'styles.dart';
import 'widgets.dart' as w;


class TomForm extends StatefulWidget {
  final Map<dynamic,dynamic> config;
  TomForm({Key key, @required this.config}) : super(key: key);
  @override
  TomFormState createState() => new TomFormState(config);
}
class TomFormState extends State<TomForm> {
String selectedkeyindropdown = "";
List checkboxselectedvalue=[];
  Map<dynamic, dynamic> config;
  Map<dynamic, dynamic> FIELD_VALUE={};
  bool termsaccepted = false;
  TomFormState(Map a){
    config = a;
    if(config["initial"]!=null)FIELD_VALUE = config["initial"];
    print(config["initial"]);
  }
  var imgFile;
  var file;
  asyncFunc(BuildContext) async {
    ut.load(this, false);
    setState(() {imgFile = null;file=null;});
  }
  post(){
    if(config["accept_terms"]!=null){
      if(config["accept_terms"]){
        print("terms_accepted: $termsaccepted");
        if(termsaccepted){
        validate();
        }
        else{
          ut.showtoast("You must accept terms", Colors.grey);
        }
      }
      else{
        validate();
      }
    }
    else{
      validate();
    }
  }
  photovalidation() async {
    if(FIELD_VALUE.containsKey("photo") && imgFile!=null){
            if(FIELD_VALUE["photo"]!=null){
              ut.load(this,true);
              await uploadimage(imgFile,this).
              timeout(Duration(seconds: 60),onTimeout: (){timeout();}).then((photourl) async {
                FIELD_VALUE["photo"] = photourl;
                filevalidation();
              });
            }
            else{
              filevalidation();
            }
          }
          else{
            filevalidation();
          }
  }
  filevalidation() async {
    if(FIELD_VALUE.containsKey("file") && file!=null){
            if(FIELD_VALUE["file"]!=null){
              ut.load(this,true);
              await uploadfile(file,this).
              timeout(Duration(seconds: 60),onTimeout: (){timeout();}).then((fileurl) 
              async {
                FIELD_VALUE["file"] = fileurl;
                submit();
              });
            }
            else{
              submit();
            }
          }
          else{
            submit();
          }
  }
  submit(){
    if(config["initial"]!=null){
      print(FIELD_VALUE["_id"]);
        //FIELD_VALUE["_id"] = mon.ObjectId.fromHexString(FIELD_VALUE["_id"]);
      FocusScope.of(context).requestFocus(FocusNode());
      Navigator.pop(context,json.encode(FIELD_VALUE));
      }
      else{
      FocusScope.of(context).requestFocus(FocusNode());
        Navigator.pop(context,json.encode(FIELD_VALUE));
      }
    
  }
  validate() async {
    print(FIELD_VALUE);
    if(config["photopicker"]!=null){
      //CHECK IF ALL FIELDS FILLED
      print(FIELD_VALUE.length);
      print(config["fields"].length);
      if(FIELD_VALUE.length>=config["fields"].length-1){
        passwordvalidation();
      }
      else{
        ut.showtoast("You must fill all fields", Colors.red);
      }
    }
    else{
      if(FIELD_VALUE.length>=config["fields"].length){
        passwordvalidation();
      }
      else{
        ut.showtoast("You must fill all fields", Colors.red);
      }
    }
    

  }
  passwordvalidation(){
    if(FIELD_VALUE["password"]!=null&&FIELD_VALUE["confirm_password"]!=null){
        //CHECK FOR PASSWORD MATCH
        if(FIELD_VALUE["password"]==FIELD_VALUE["confirm_password"]){
          //cut-off confirm_password field from output
          FIELD_VALUE.remove("confirm_password");
          //Encrypt password
          FIELD_VALUE["password"] = ut.encrypt(FIELD_VALUE["password"]);
          photovalidation();
        }
        else{
          ut.showtoast("Passwords doesn't match", Colors.red);
        }
      }
      else{
        photovalidation();
      }
  }
  timeout(){
    //ut.showtoast("Time out", Colors.red);
    }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => start(context));
  }
  void start(BuildContext){asyncFunc(BuildContext);}
  @override void dispose() {
    config=null;file = null;imgFile=null;imageselected  =null;super.dispose();}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Form',
        theme: maintheme(),
        home: Scaffold(
            appBar: AppBar(
              leading: Icon((config["icon"]!=null)?
              config["icon"]:Icons.assignment),
              title: Text((config["title"]!=null)?
              config["title"]:'Form'),
            ),
            body: Container(
              decoration: bg(),
              child:
              Stack(children:[
                if(!loading)SingleChildScrollView(
                  child:Container(
                      margin: EdgeInsets.all(10),
                      decoration: ut.mycard(Colors.white, 5.0, 5.0),
                      padding: EdgeInsets.all(10),
                      child:Column(
                        children: <Widget>[
                          addform(),
                      if(config["accept_terms"]!=null)if(config["accept_terms"])acceptterms(),
                          postbutton(),
                        ],
                      )
                  )
              ),
              if(loading)w.loader()
              ])
              
            )));
  }
  Widget acceptterms(){
    return Container(
        padding: EdgeInsets.all(5),
        child:Column(children: <Widget>[
      Text(terms,style: TextStyle(fontWeight: FontWeight.w400),),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        Text("Accept terms and conditions",
          style: TextStyle(fontWeight: FontWeight.w700),),
        checkboxterms("#terms", this)
      ],)
    ],));
  }
  Widget addform(){
    List li = config["fields"];
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: li.map((item) =>
          (!item.toString().contains("*"))?formitem(item.split("#")[0],
              item.split("#")[1],this):Container()
          ).toList()
      ),
    );
  }
   //================= image =================
   bool imageselected = false;
  Widget profilephotopicker(String t){
    return InkWell(
      onTap: () async {
        //50 - Image quality
        var temp =  await showimageselector(this,50);
        setState(() {imageselected = true;});
        setState(() {imgFile = temp;});
        FIELD_VALUE["photo"] = temp;
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
                  (config["initial"]==null)?
                  (imgFile == null)
                      ? Text('No image selected.')
                      : Image.memory(imgFile.data)
                      :
                  (!imageselected)?
                  (FIELD_VALUE['photo']!=null)?
               image(FIELD_VALUE['photo']):
                  Text("No image selected")
                      :Image.memory(imgFile.data)
              ),
            ),
            Expanded(
              flex: 1, // 30%
              child: Container(child: Icon(Icons.add_a_photo,
              color: Colors.purple,)),
            ),
            if(imgFile!=null||(config["initial"]!=null &&
                FIELD_VALUE['photo']!=null))Expanded(
              flex: 1, // 30%
              child: InkWell(child:Container(child:
              Icon(Icons.cancel,color: Colors.grey,)),
                  onTap: (){setState(() {imgFile=null;
                  FIELD_VALUE['photo']=null;});}
              ),
            ),
          ],
        ),),);
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
  Future<String> uploadfile(var file,State m) async {
    m.setState(() {loadingtext="Uploading file ...";});
    
  ut.load(m,true);
  //String extension = 'png';
  String filename = file.name.toString();
  
  final String fileName = randomNumeric(5)+filename;
  final String phpEndPoint = '$imageurl/files/upload.php';
  String base64Image = base64Encode(file.readAsBytes);
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
  Widget filepicker(String t,bool editmode,State m) {
    return InkWell(
      onTap: () async {
        if (editmode) {
          ut.showtoast(
              "You cant change file. Delete current file then Upload new files",
              Colors.red);
        } else {
       var temp = await pickfile(m);
          print(temp);
          m.setState(() {
            file = temp;
         });
          FIELD_VALUE["file"] = temp;
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
                      ? (file == null) ? Text('No file selected.') :filetext()
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
  Widget postbutton(){
    return Container(
        color: Colors.white.withOpacity(0.5),
        padding: EdgeInsets.symmetric(vertical:20,horizontal: 50),
        child:InkWell(
          child: Container(
            margin: EdgeInsets.all(0),
            padding: EdgeInsets.all(3),
            decoration: w.rounded(Colors.blue[400],40),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: <Widget>[
                Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                    child:Text("SUBMIT",style: TextStyle(color: Colors.white,
                        fontWeight:FontWeight.w600 ),)),
                ut.circleicon(Icons.keyboard_arrow_right, Colors.black, Colors.white,
                    20),
              ],),
          ),
          onTap: (){post();},
        )
    );
  }
  Widget formitem(String title,String type,State m)=>
      Container(
        color: Colors.grey[100],
        padding: EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            Expanded(flex: 1, // 30%
              child: Container(child: Icon(
                (title.contains("date")==true)?
                Icons.date_range:
                (title.contains("bool")==true)?
                Icons.playlist_add_check:
                (title.contains("photo")==true)?
                Icons.image:
                (title.contains("name")==true)?
                Icons.person:
                (title.contains("password")==true)?
                Icons.lock:
                (title.contains("email")==true)?
                Icons.email:
                (title.contains("place")==true ||
                    title.contains("location")==true)?
                Icons.location_on:
                (title.contains("school")==true ||
                    title.contains("college")==true)?
                Icons.account_balance:
                (title.contains("time")==true)?
                Icons.access_time:
                Icons.keyboard,
                color: (config["field_icon_color"]!=null)?
                config["field_icon_color"]:Colors.pink,)),
            ),
            Expanded(flex: 2, // 30%
              child: Container(child: Text("${capitalize(title.replaceAll('_', ' ').replaceAll('bool', '').split("#")[0])}"),),
            ),
            Expanded(flex: 6, // 70%
              child: Container(
                  decoration: w.rounded(Colors.grey[200], 30),
                  child:
                  Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                      child:
                      (type == "dropdowncheck") ? 
                     (config[title]!=null)? dropdowncheck(title, config[title])  
                            :error("Dropdown list not found in config",)
                      : 
                      (type=="date")?
                      datepicker(m, Colors.orange, "$title"):
                      (type=="time")?
                      timepicker(m, Colors.orange, "$title"):
                      (type=="checkbox")?
                      checkbox(title, m):
                      (type=="photo")?
                      profilephotopicker(title):
                      (type=="file")?
                      filepicker(title,false,this):
                      (type=="dropdown")?
                      (config[title]!=null)?dropdownplain(title, config[title])
                            :error("Dropdown list not found in config",)
                          :
                      (type=="text"||type=="textarea")?
                      blanktextfield(title,
                          (title.contains("phone"))?1:0,
                          (type=="textarea")?10:1)
                          :Text("Unknown fieldtype")

                  )),
            ),
          ],),);
  Widget error(String txt){
    return Row(children: <Widget>[
      Icon(Icons.warning,color: Colors.red,),
      SizedBox(width: 5,),
      Expanded(child: Text(txt,style: TextStyle(color: Colors.red),),)

    ],);
  }
  Widget datepicker(State m,Color cl,String id){
    return FlatButton(
        onPressed: () {

        DatePicker.showDatePicker(m.context,
              showTitleActions: true,
               onChanged: (date) {
                print('change ${date.day}');
              }, onConfirm: (d) {
                print("DATE: $d");
                FocusScope.of(m.context).requestFocus(new FocusNode()); //remove focus
                m.setState(() {
                  FIELD_VALUE[id] = d.millisecondsSinceEpoch;});
                //print(FIELD_VALUE);
              }, currentTime: DateTime.now(), locale: LocaleType.en);

        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            Text((FIELD_VALUE!=null)?(FIELD_VALUE[id]!=null)?
            "${DateTime.fromMillisecondsSinceEpoch(FIELD_VALUE[id]).toString().split(' ')[0]}":
            "Pick date":"none",textAlign: TextAlign.start,
              style: TextStyle(color: Colors.blue),),
          ],
        ),
        //color: cl,
        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20))
    );
  }
  Widget timepicker(State m,Color cl,String id){
    return FlatButton(
        onPressed: () {

          DatePicker.showTimePicker(m.context,
              showTitleActions: true,
              onChanged: (date) {
              }, onConfirm: (d) {
                FocusScope.of(m.context).requestFocus(new FocusNode()); //remove focus

                if(config["fields"].contains("date")){
                  if(FIELD_VALUE["date"]==null){
                    ut.showtoast("pick date first", Colors.red);
                  }
                  else{
                    print(d);

                    String time = d.toString().split(" ")[1];
                    DateTime ipdate = DateTime.
                    fromMillisecondsSinceEpoch(FIELD_VALUE["date"]);
                    String date = ipdate.toString().split(" ")[0];
                    String combined = "$date $time";
                    DateTime nDate = DateTime.parse(combined);
                    setState(() {
                      FIELD_VALUE[id] = nDate.millisecondsSinceEpoch;
                    });

                  }
                }
                else{
                  setState(() {
                    FIELD_VALUE[id] = d.millisecondsSinceEpoch;
                  });
                }


                //print(FIELD_VALUE);
              }, currentTime: DateTime.now(), locale: LocaleType.en);

        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            Text((FIELD_VALUE!=null)?(FIELD_VALUE[id]!=null)?
            "${DateTime.fromMillisecondsSinceEpoch(FIELD_VALUE[id]).toString().split(' ')[1]}":
            "none":"none",textAlign: TextAlign.start,
              style: TextStyle(color: Colors.purple),),
          ],
        ),
        //color: cl,
        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20))
    );
  }
  Widget blanktextfield(String txt,int keyboard_type,int maxlines){
    return new Container(
        width: 120,
        child:TextFormField(
          maxLines: maxlines,
          decoration: new InputDecoration(
            labelText: "Enter "+txt,
            contentPadding: EdgeInsets.all(0.0),
            fillColor: Colors.white,
          ),
          onChanged: (val){
            FIELD_VALUE[txt] = val;
          },
          initialValue: (config["initial"]!=null)?config["initial"][txt]:"",
          //inputFormatters: (keyboard_type==1)?[WhitelistingTextInputFormatter.digitsOnly]:[],
          keyboardType: (keyboard_type==1)?TextInputType.number:TextInputType.text,
          style: new TextStyle(
            color: Colors.black,
            fontFamily: "Poppins",
          ),
        ));
  }
  Widget checkbox(String id,State m){
    return Align(alignment: Alignment.centerLeft,
      child:Checkbox(
        checkColor: Colors.white,
        activeColor: Colors.blue,
        value: (FIELD_VALUE!=null)?(FIELD_VALUE[id]!=null)?
        (FIELD_VALUE[id]=="true")?true:false
            :false:false,
        onChanged: (bool value) {
          m.setState(() {FIELD_VALUE[id] = value.toString();});
        },
      ),);
  }
  
  Widget checkboxindropdown(String id,String val,String item,State m){
    return Align(alignment: Alignment.centerLeft,
      child:Checkbox(
        checkColor: Colors.white,
        activeColor: Colors.blue,
        value: (FIELD_VALUE!=null)?(FIELD_VALUE[id]!=null)?
       FIELD_VALUE[id][val] == null ? false : (FIELD_VALUE[id][val].contains(item))?true:false
            :false:false,
        onChanged: (bool value) {
          m.setState(() {
            value ? checkboxselectedvalue.contains(item) ? print("") :
            checkboxselectedvalue.add(item) :checkboxselectedvalue.contains(item) ? 
            checkboxselectedvalue.remove(item) : print("") ;
            FIELD_VALUE[id] = {val:checkboxselectedvalue} ;});
           print(FIELD_VALUE);
            
        },
      ),);
  }
  Widget checkboxterms(String id,State m){
    return Align(alignment: Alignment.centerLeft,
      child:Checkbox(
        checkColor: Colors.white,
        activeColor: Colors.blue,
        value: termsaccepted,
        onChanged: (bool value) {
          m.setState(() {termsaccepted=value;});
        },
      ),);
  }
  Widget dropdowncheck(String id,Map lix){
    String selectedkey = " ";
    String formatted_id=id.split("#")[0];
    return Column(
      children: <Widget>[
        Container(
            padding: EdgeInsets.all(10.0),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                iconEnabledColor: Colors.blue,
                isDense: true,
                hint: Text((FIELD_VALUE[formatted_id]!=null)?
                "${FIELD_VALUE[formatted_id].toString().split(":")[0].substring(1)}":"Select Item",
                  style: TextStyle(color: Colors.blue),textAlign: TextAlign.center,),
                items: lix
                    .map((key,value) { 
                      return MapEntry(key, 
                       DropdownMenuItem(
                  child: Container(color:Colors.transparent,child:Text(" "+key,
                    style:TextStyle(color: Colors.black) ,)),
                  value: key,
                ));
                    }
                ).values
                
                    .toList(),
                onChanged: (value) {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  print("value changed");
                  print('new value:$value');
                  setState(()
                  {
              checkboxselectedvalue.clear();
                    selectedkeyindropdown = value.toString();
                   // print(value);
                  // print("selected:"+selectedkey);
                  print(lix[selectedkeyindropdown]);
                   // print(lix[selectedkey]["batch"]);
                    FIELD_VALUE[formatted_id]={value:null};
                    print(FIELD_VALUE[formatted_id]);
                  });
                //  checkbox(id, lix[value]);
                },
                isExpanded: false,
              ),
            )
        ),
       selectedkeyindropdown == "" ? Container():
       lix[selectedkeyindropdown] == null ? Container()
       :
       Column(children:[
         for(var i in lix[selectedkeyindropdown].split(",") ) 

         Row(

           children: <Widget>[
             Text(i.toString().replaceAll('"', "").replaceAll("[", "").replaceAll("]", "")),
              checkboxindropdown("class", selectedkeyindropdown,i.toString().replaceAll('"', "").replaceAll("[", "").replaceAll("]", "") ,this)
           ],
         )
        // lix[selectedkeyindropdown].split(",").map((value)=>
        // print("rafi "+value)
        // Text(value.toString()),
        // ).toList()
       ])
       
       // Text("Testing")
      ],
    );
  }
    Widget dropdownplain(String id,List lix){
    String formatted_id=id.split("#")[0];
    return Container(
        padding: EdgeInsets.all(10.0),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            iconEnabledColor: Colors.blue,
            isDense: true,
            hint: Text((FIELD_VALUE[formatted_id]!=null)?
            "${FIELD_VALUE[formatted_id]}":"Select Item",
              style: TextStyle(color: Colors.blue),textAlign: TextAlign.center,),
            items: lix
                .map((value) => DropdownMenuItem(
              child: Container(color:Colors.transparent,child:Text("$value",
                style:TextStyle(color: Colors.black) ,)),
              value: value,
            ))
                .toList(),
            onChanged: (value) {
              FocusScope.of(context).requestFocus(new FocusNode());
              print("value changed");
              print('new value:$value');
              setState(()
              {
                FIELD_VALUE[formatted_id]=value;
              });
            },
            isExpanded: false,
          ),
        )
    );
  }
}