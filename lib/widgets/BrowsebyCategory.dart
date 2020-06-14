import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';
import '../utils/utils.dart';

class Grid extends StatefulWidget {
  @override
  GridState createState() => new GridState();
}
class GridState extends State<Grid> {
  //THIS IS DUMMY DATA ONLY < ITS MUST BE FETCHED FROM DATABASE
  Map<dynamic,dynamic> cat = {
  "Beverages":{"name":"Beverages","ico":"Beverages/beverages"},
    "Cosmetics":{"name":"Beverages","ico":"Cosmetics/nailpaint"},
    "Dry fruits":{"name":"Beverages","ico":"Dry fruits/dry fruits"},
    "Edible oil":{"name":"Beverages","ico":"Edible oil/edible oil"},
  "Fruits":{"name":"Beverages","ico":"Fruits/fruits"},
  "Meat":{"name":"Beverages","ico":"Meat/meat"},
  "Rice and floor":{"name":"Beverages","ico":"rice_and_floor/rice and flour"},
  "Stationary":{"name":"Beverages","ico":"Stationary/stationary"},
  "Sweets":{"name":"Beverages","ico":"Sweets/icecream"},
  "Vegetables":{"name":"Beverages","ico":"Vegetables/tomato"},
    };
    List name = [];
   asyncFunc(BuildContext) async {
     for (var i in cat.keys) {
       name.add(i);
     }
   }
  void start(BuildContext){asyncFunc(BuildContext);}
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => 
    start(context));
  }
  @override
  void dispose() {super.dispose();}

  @override
  Widget build(BuildContext context) {
    return Center(child:Container(
      color: Colors.white,
        width: 1000,
          child:ResponsiveGridList(
            scroll: false,
        desiredItemWidth: 100,
        minSpacing: 10,
        
        children: name.map((i) {
          return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                (cat[i]["ico"]!=null)?img(cat[i]["ico"]):
                roundicon(Icons.shopping_cart, Colors.grey[300],
                    Colors.grey[100], 50, 10),
              Text(i,style: TextStyle(fontSize: 18),textAlign: TextAlign.center,)
            ],);
        }).toList()
        
    )
    ));
  }
  
  Widget img(img){
    return ClipRRect(
      borderRadius: BorderRadius.circular(200.0),
      child: Image.asset(
        'assets/icons/' +
            img +
            ".png",
        width: 80,
        height: 80,
      )
    );
  }
}
Color v = Colors.black;
Widget titler(State m){
  return Container(
        color: Colors.amber,
      width: 1000,
      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "Browse by category",
            style: TextStyle(
                fontSize: 20,
                color: Color(0xFF3a3a3b),
                fontWeight: FontWeight.w300),
          ),
          Expanded(child: Container(),),
          InkWell(
      onTap:(){},
      onHover:(val){
        m.setState(() {(val)?v=Colors.blue:v=Colors.black;});
        },
      child:Text(
            "See all",
            style: TextStyle(
                fontSize: 16, color: v,
                fontWeight: FontWeight.w300),
          )), Icon(Icons.keyboard_arrow_right, color: v,)
        ],
      ),
    );
}
