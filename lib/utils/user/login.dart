import 'dart:convert';
import 'dart:io';

import 'package:compass_rent_car/utils/dev.dart';

import '../../globals.dart';
import '../styles.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Login extends StatefulWidget {
  //final String text,name;
  //Base({Key key, @required this.text,@required this.name}) : super(key: key);
  @override
  //BaseState createState() => new BaseState(text,name);
  LoginState createState() => new LoginState();
}
class LoginState extends State<Login> {
  String errortxt="";
  TextEditingController userid = new TextEditingController();
  TextEditingController pwd = new TextEditingController();
  asyncFunc(BuildContext) async {

  }
  signin() async {
    var user = await checkuserexists(userid.text);
    print(user);
    if(user==false){setState(() {
      errortxt="User doesn't exists";
    });}
    else{
      //check password
      Map<dynamic, dynamic> userdata = json.decode(user);
      if(userdata["pwd"].toString()==pwd.text){gotodashboard();}
      else{setState(() {errortxt = "Incorrect password";});
      }
      
    }
  }
  gotodashboard(){
    print("Logged in succesfully");
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            
            image: DecorationImage(
              
              image: AssetImage('images/banner1.jpg'),
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
              
            ),
            color: Colors.pink.withOpacity(0.5),
          ),
        ),
        Center(child:Container(
          margin: EdgeInsets.symmetric(horizontal:100),
          width: 400,
          padding: EdgeInsets.all(20),
          color: Colors.white54,
          //decoration: mycard(Colors.white, 10.0, 5.0),
          child: 
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(children:[
                  Icon(Icons.directions_car, color: Colors.pink,),
                  SizedBox(width:10),
                    Text("Compass rent car", 
                style: TextStyle(color: Colors.pink, 
                fontSize: 20, fontWeight: FontWeight.w700),),
                ]),
                
                Divider(),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Container(
                    //color: Color(0xfff5f5f5),
                    decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: Colors.grey[200],
          ),
                    child: TextFormField(
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'SFUIDisplay'
                      ),
                      controller: userid,
                      onChanged: (val){setState(() {errortxt="";});},
                      decoration: iprounded("Username",
                       Icons.person_outline)
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: Colors.grey[200],
          ),
                  child: TextFormField(
                    obscureText: true,
                    onChanged: (val){setState(() {errortxt="";});},
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'SFUIDisplay'
                    ),
                    controller: pwd,
                    decoration: iprounded("Password",
                       Icons.lock_outline)
                  ),
                ),
                if(errortxt!="")SizedBox(height: 10,),
                if(errortxt!="")Text(errortxt, style: TextStyle(
                  fontSize: 20,fontWeight: FontWeight.w800,
                  color: 
                Colors.red),),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: MaterialButton(
                    onPressed: (){
                      signin();
                    },//since this is only a UI app
                    child: Text('SIGN IN',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'SFUIDisplay',
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                    color: Color(0xffff2d55),
                    elevation: 0,
                    minWidth: 400,
                    height: 50,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Center(
                    child: Text('Forgot your password?',
                    style: TextStyle(
                      fontFamily: 'SFUIDisplay',
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }

}