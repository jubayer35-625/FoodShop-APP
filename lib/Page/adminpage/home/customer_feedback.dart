import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CustomerFeedBack extends StatefulWidget{
  const CustomerFeedBack({Key? key}) : super(key: key);

  @override
  State<CustomerFeedBack> createState() => _CustomerFeedBackState();
}

class _CustomerFeedBackState extends State<CustomerFeedBack> {

  var timeOfDv;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title:Text("CustomerFeedBack"),
        leading: Icon(Icons.history),
      ),
      body: SizedBox(

        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child:Column(
                children: [
                ],
              )
            ),
          ),
        ),
      )
    );
  }
  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = FlatButton(
      child: const Text("OK"),
      onPressed: () async{

        Navigator.of(context).pop();
      },
    );

    Widget NoButton = FlatButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    Widget TextBox = TextFormField(
      decoration: InputDecoration(
        labelText: 'delivery time',
        counterText:'',
        labelStyle: const TextStyle(fontSize: 18.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        errorStyle:
        const TextStyle(color: Colors.redAccent, fontSize: 12),
      ),
      autofocus: true,
      validator: (_val){
        if(_val!.isEmpty){
          return"cant be Emoty";
        }else{
          return null;
        }
      },
      onChanged:(_val){
        timeOfDv=_val;
      },
    );
    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delivery time"),
      // content: Text("This is an alert message."),
      actions: [
        TextBox,
        Row(
          children: [
            okButton,
            SizedBox(width: 50),
            NoButton,
          ],
        )

      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}