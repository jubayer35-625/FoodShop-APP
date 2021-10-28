import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget{
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("History"),centerTitle: true,
      leading: Icon(Icons.history_toggle_off_outlined),),
    );
  }
}