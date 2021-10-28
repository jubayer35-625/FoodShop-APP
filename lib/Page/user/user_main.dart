import 'package:authui/Page/user/hompage/homepage.dart';
import 'package:authui/Page/user/profile/profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'addtocard/mycart.dart';
import 'history/history.dart';
class UserMain extends StatefulWidget {
  const UserMain({Key? key}) : super(key: key);

  @override
  _UserMainState createState() => _UserMainState();
}

class _UserMainState extends State<UserMain> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    HomeCustomer(),
    MyCartPage(),
    HistoryPage(),
    ProfilePage(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar:CurvedNavigationBar(
      height:50,
      items: <Widget>[
        Icon(Icons.home_outlined, size: 30,color: Colors.white,),
        Icon(Icons.add_shopping_cart,size: 30,color: Colors.white,),
        Icon(Icons.add_alert,size: 30,color: Colors.white,),
        Icon(Icons.account_circle_outlined,size: 30,color: Colors.white,),
      ],
      onTap: _onItemTapped,
      backgroundColor: Colors.deepPurple.withOpacity(0.7),
      buttonBackgroundColor: Colors.pinkAccent,
      animationCurve: Curves.easeInOut,
      animationDuration: Duration(milliseconds: 600),
      color:Colors.deepPurple,
    ),
    );
  }
}
