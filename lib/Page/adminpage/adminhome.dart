
import 'package:authui/Page/adminpage/home/admin_profile.dart';
import 'package:authui/Page/adminpage/home/customer_feedback.dart';
import 'package:authui/Page/adminpage/home/item_list_home.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
class AdminHome extends StatefulWidget{
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
    int _selectedIndex = 0;

    final tabs = [
      ItemPage(),
      CustomerFeedBack(),
      AdminProfile()
    ];

    void _onItemTap(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.deepPurple,
        body: tabs[_selectedIndex],


        bottomNavigationBar:CurvedNavigationBar(
          height:50,
          items: <Widget>[
            Icon(Icons.home_outlined, size: 30,color: Colors.white,),
            Icon(Icons.add_alert, size: 30),
            Icon(Icons.account_circle_outlined, size: 30),
          ],
          onTap: _onItemTap,
          backgroundColor: Colors.white,
          buttonBackgroundColor: Colors.pinkAccent,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          color:Colors.deepPurple,
        ),

      );
  }
}