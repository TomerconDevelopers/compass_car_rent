import 'package:compass_rent_car/utils/styles.dart';
import 'package:compass_rent_car/utils/utils.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
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
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'SFUIDisplay'
                    ),
                    decoration: iprounded("Password",
                       Icons.lock_outline)
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: MaterialButton(
                    onPressed: (){},//since this is only a UI app
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