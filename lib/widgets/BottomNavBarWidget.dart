import 'package:flutter/material.dart';

class BottomNavBarWidget extends StatefulWidget {
  @override
  _BottomNavBarWidgetState createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;
    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
//        navigateToScreens(index);
      });
    }

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text(
            'Home',
            style: TextStyle(color: Color(0xFF2c2b2b)),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          title: Text(
            'Wish List',
            style: TextStyle(color: Color(0xFF2c2b2b)),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          title: Text(
            'Cart',
            style: TextStyle(color: Color(0xFF2c2b2b)),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          title: Text(
            'Account',
            style: TextStyle(color: Color(0xFF2c2b2b)),
          ),
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber,
      showSelectedLabels: true,
      onTap: _onItemTapped,
    );
  }
}
