import 'package:flutter/material.dart';
import '../animation/RotationRoute.dart';
import '../animation/ScaleRoute.dart';
import '../pages/FoodDetailsPage.dart';

class BestOffersWidget extends StatefulWidget {
  @override
  BestOffersWidgetState createState() => BestOffersWidgetState();
}

class BestOffersWidgetState extends State<BestOffersWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 265,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          PopularFoodTitle(),
          Expanded(
            child: PopularFoodItems(),
          )
        ],
      ),
    );
  }
}

class BestOfferTiles extends StatelessWidget {
  String name;
  String imageUrl;
  String rating;
  String numberOfRating;
  String offerprice;String price;
  String slug;

  BestOfferTiles(
      {Key key,
      @required this.name,
      @required this.imageUrl,
      @required this.rating,
      @required this.numberOfRating,
      @required this.offerprice,@required this.price,
      @required this.slug})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, ScaleRoute(page: FoodDetailsPage()));
      },
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
            child: Card(
                color: Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                ),
                child: Container(
                  width: 170,
                  //height: 230,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10,),
                      Stack(
                        children: <Widget>[

                          Align(
                            alignment: Alignment.centerLeft,
                            child: Center(
                                child: Image.asset(
                              'assets/images/popular_foods/' +
                                  imageUrl +
                                  ".png",
                              width: 130,
                              height: 120,
                            )),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.bottomLeft,
                            padding: EdgeInsets.only(left: 5, top: 5),
                            child: Text(name,
                                style: TextStyle(
                                    color: Color(0xFF6e6e71),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500)),
                          ),
                          Container(
                            alignment: Alignment.topRight,
                            padding: EdgeInsets.only(right: 5),
                            child: Container(
                              height: 28,
                              width: 28,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white70,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xFFfae3e2),
                                      blurRadius: 25.0,
                                      offset: Offset(0.0, 0.75),
                                    ),
                                  ]),
                              child: Icon(
                                Icons.favorite_border,
                                color: Colors.blue,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[

                          Text('\₹ ${price}',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  decoration: TextDecoration.lineThrough,
                                  fontWeight: FontWeight.w400)),
                          SizedBox(width: 10,),

                          Container(
                            alignment: Alignment.bottomLeft,
                            padding: EdgeInsets.only(left: 5, top: 0, right: 5),
                            child: Text('\₹ ${(offerprice!=null)?
                            offerprice:price}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800)),
                          )
                        ],
                      ),
              SizedBox(height: 10,)
              //ratingbar()
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }

  Widget ratingbar(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(left: 5, top: 5),
          child: Text(rating,
              style: TextStyle(
                  color: Color(0xFF6e6e71),
                  fontSize: 10,
                  fontWeight: FontWeight.w400)),
        ),
        Container(
          padding: EdgeInsets.only(top: 3, left: 5),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.star,
                size: 10,
                color: Color(0xFFfb3132),
              ),
              Icon(
                Icons.star,
                size: 10,
                color: Color(0xFFfb3132),
              ),
              Icon(
                Icons.star,
                size: 10,
                color: Color(0xFFfb3132),
              ),
              Icon(
                Icons.star,
                size: 10,
                color: Color(0xFFfb3132),
              ),
              Icon(
                Icons.star,
                size: 10,
                color: Color(0xFF9b9b9c),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(left: 5, top: 5),
          child: Text("($numberOfRating)",
              style: TextStyle(
                  color: Color(0xFF6e6e71),
                  fontSize: 10,
                  fontWeight: FontWeight.w400)),
        ),
      ],
    );
  }
}

class PopularFoodTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "Best Offers",
            style: TextStyle(
                fontSize: 20,
                color: Color(0xFF3a3a3b),
                fontWeight: FontWeight.w300),
          ),
          Expanded(child: Container(),),
          Text(
            "See all",
            style: TextStyle(
                fontSize: 16, color: Colors.blue,
                fontWeight: FontWeight.w300),
          ), Icon(Icons.keyboard_arrow_right, color: Colors.blue,)
        ],
      ),
    );
  }
}

class PopularFoodItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        BestOfferTiles(
            name: "Red chilly",
            imageUrl: "ic_popular_food_1",
            rating: '4.9',
            numberOfRating: '200',
            offerprice: '69',
            price: '119',
            slug: "fried_egg"),
        BestOfferTiles(
            name: "Cashew",
            imageUrl: "ic_popular_food_3",
            rating: "4.3",
            numberOfRating: "100",
            offerprice: "99",
            price: '209',
            slug: ""),
        BestOfferTiles(
            name: "Salad With Chicken",
            imageUrl: "ic_popular_food_4",
            rating: "4.0",
            numberOfRating: "50",
            price: "11.00",
            slug: ""),
        BestOfferTiles(
            name: "Mixed Salad",
            imageUrl: "ic_popular_food_5",
            rating: "4.00",
            numberOfRating: "100",
            price: "11.10",
            slug: ""),
        BestOfferTiles(
            name: "Red meat,Salad",
            imageUrl: "ic_popular_food_2",
            rating: "4.6",
            numberOfRating: "150",
            price: "12.00",
            slug: ""),
        BestOfferTiles(
            name: "Mixed Salad",
            imageUrl: "ic_popular_food_5",
            rating: "4.00",
            numberOfRating: "100",
            price: "11.10",
            slug: ""),
        BestOfferTiles(
            name: "Potato,Meat fry",
            imageUrl: "ic_popular_food_6",
            rating: "4.2",
            numberOfRating: "70",
            price: "23.0",
            slug: ""),
        BestOfferTiles(
            name: "Fried Egg",
            imageUrl: "ic_popular_food_1",
            rating: '4.9',
            numberOfRating: '200',
            price: '15.06',
            slug: "fried_egg"),
        BestOfferTiles(
            name: "Red meat,Salad",
            imageUrl: "ic_popular_food_2",
            rating: "4.6",
            numberOfRating: "150",
            price: "12.00",
            slug: ""),
      ],
    );
  }
}


