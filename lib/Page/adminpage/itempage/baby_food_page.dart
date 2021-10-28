import 'package:flutter/material.dart';

class BabyFoodPage extends StatefulWidget{
  const  BabyFoodPage({Key? key}) : super(key: key);

  @override
  State<BabyFoodPage> createState() => _BabyFoodPageState();
}

class _BabyFoodPageState extends State<BabyFoodPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title:Text("CustomerFeedBack"),
        leading: Icon(Icons.history),
      ),
      body: Center(
        child: Text("Customer Feedback"),
      ),
    );
  }
}