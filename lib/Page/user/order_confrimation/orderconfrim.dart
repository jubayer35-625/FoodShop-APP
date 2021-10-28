import 'dart:async';
import 'dart:ffi';

import 'package:authui/Widgets/button_icon.dart';
import 'package:authui/Widgets/text_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../user_main.dart';

class OrderConfrimation extends StatefulWidget{
  const OrderConfrimation({Key? key}) : super(key: key);

  @override
  State<OrderConfrimation> createState() => _OrderConfrimationState();
}

class _OrderConfrimationState extends State<OrderConfrimation> {
 var now = DateTime.now();
 final DateFormat formatter = DateFormat();
 var DTime="";
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final email = FirebaseAuth.instance.currentUser!.email;
  var value;
  var _value = 1;
  var changeLoct="";
  var foodname,ItemCode,valueofItem,totalamount,totalItems,deliveryChrage;
  var paymentWay,DeliveryAddredd,name,mobile,localaddress;
  var xx=0;
  var mass="";
void initState()  {
  final String formatted = formatter.format(now);
  DTime=formatted.toString();
  FirebaseFirestore.instance.collection("users").doc(uid).collection("mycart").doc(uid).collection("mycart").get().then(
        (querySnapshot) {
      querySnapshot.docs.forEach((result) {
        xx++;

        foodname=result.data()['foodName'];
        valueofItem=result.data()['valueitems'];
        ItemCode=result.data()['itemcode'];

          FirebaseFirestore.instance.collection("Manager").doc("OrderCheekup").collection(uid).doc("InfoFoods").collection(DTime).doc('item-$xx').set(
              {
                'foodName': foodname.toString(),
                'valueOfItem':valueofItem.toString(),
                'itemcode':ItemCode.toString(),
                'uid':uid.toString(),
                'datetime': DTime
              }
          ) ;


      });
    },
  );
  super.initState();
}



  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    // TODO: implement build

    return Scaffold(
      backgroundColor: Colors.white.withOpacity(.7),
      appBar: AppBar(
        title: const Text("Order Confirmation"),
        centerTitle: true,
      ),
body: Padding(
  padding:  EdgeInsets.all(w*0.012),
  child:   SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        SizedBox(height: h*0.0075,),
        Row(
          children: [
            Text("Payment Method :",style: TextStyle(fontSize: w*0.034,color: Colors.black,fontWeight: FontWeight.bold),),
            SizedBox(width: w*0.038,),


            Container(
              width:w*0.5,
              height:h*0.04,
              decoration:BoxDecoration(
                  border: Border.all(
                    width:1,
                  ),
                  borderRadius: const BorderRadius.all(
                      Radius.circular(8) //                 <--- border radius here
                  ),
                  color: Colors.blue.withOpacity(.3)
              ) ,
              child:Center(
                child: DropdownButton(
                    dropdownColor: Colors.blue.withOpacity(0.8),
                    focusColor: Colors.pinkAccent,
                    value: _value,
                    itemHeight: h*0.1,
                    items: [
                      DropdownMenuItem(
                        child: const Text("CashOn Delivary"),
                        value: 1,
                        onTap: (){
                          _value=1;
                        },
                      ),
                      DropdownMenuItem(
                        child: const Text("Bkash"),
                        value: 2,
                        onTap: (){_value=2;},
                      ),
                      DropdownMenuItem(
                        child: const Text("Rocket"),
                        value: 3,
                        onTap: (){_value=3;},
                      ),
                      DropdownMenuItem(
                        child: const Text("Nagod"),
                        value: 4,
                        onTap: (){_value=4;},
                      )
                    ],
                    onChanged: (value) {
                      setState(() {
                        _value=_value;
                        print(_value);
                      });
                    }),
              ),
            ),

          ],
        ),
        SizedBox(height:h*0.02,),
        Row(
          children: [
            TextWidget(text: "Delivery Address : ",size:w*0.034,color: Colors.black,fontWeight: FontWeight.bold,),
            SizedBox(width: w*0.4,),
            ButtonIconWidget(text: "change", text_color: Colors.pink, text_size: w*0.037,
              icon: Icons.edit_location,icon_size:w*0.042,iconcolor: Colors.pink,
              btn_border_color: Colors.white,btn_border_size: 8,
              onClicked: (){
                showAlertDialog(context);
              },
            )
          ],
        ),
        Container(height: h*0.1,width:w,
        margin: const EdgeInsets.only(left: 5),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("users").doc(uid).collection("OrderAddress").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot>snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
               // physics: const FixedExtentScrollPhysics(),
                itemBuilder: (context,i){
                  QueryDocumentSnapshot x = snapshot.data!.docs[i];
                  return Text((DeliveryAddredd=x['address']));
                },
                itemCount: snapshot.data!.docs.length,
              );//list
            }
            return const Center(child:  CircularProgressIndicator());
          },//buil
        ),
        ),
        SizedBox(height: h*.02,),
        const Text("Order About : ",style: TextStyle(fontWeight: FontWeight.bold,),),
        Container(
          margin: const EdgeInsets.only(left: 5,right: 5),
          height: h*0.34,
          width: w,
        //  color: Colors.orangeAccent.withOpacity(.3),
          child:Column(
            children: [
              Row(
                children: const [
                  Text("Foods Name"),
                  SizedBox(width: 50,),
                  Text("Quantity"),
                ],
              ),
              SingleChildScrollView(
                child: SizedBox(
                  height: h*0.21,
                  width: w,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("users").doc(uid).collection("mycart").doc(uid).collection("mycart").snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot>snapshot){
                      if(snapshot.hasData){
                        return ListView.builder(
                          // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                        //  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                          itemBuilder: (context,i){
                            QueryDocumentSnapshot x = snapshot.data!.docs[i];
                            return Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(x["foodName"]+"  -  "+x[ 'valueitems']),
                                ],
                              ),
                            );
                          },
                          itemCount: snapshot.data!.docs.length,
                        );//list
                      }
                      return const Center(child:  CircularProgressIndicator());
                    },//buil
                  ),
                ),
              ),
              SingleChildScrollView(
                child: SizedBox(
                  height: h*0.1,
                  width: w,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("users").doc(uid).collection("amount").snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot>snapshot){
                      if(snapshot.hasData){
                        return ListView.builder(
                          // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                       //   physics: const FixedExtentScrollPhysics(),
                          itemBuilder: (context,i){
                            QueryDocumentSnapshot x = snapshot.data!.docs[i];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text("Total Amount : "+(totalamount=x['totalAmount']).toString(),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                                Text("Total Items : "+(totalItems=x['items']).toString()),
                                Text("Delivary Charages : "+(deliveryChrage=x['delivary']).toString()),
                              ],
                            ) ; //conta
                          },
                          itemCount: snapshot.data!.docs.length,
                        );//list
                      }
                      return const Center(child:  CircularProgressIndicator(color: Colors.pink,));
                    },//buil
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: h*.02,),
        TextWidget(text: "Your Information : ",size: w*0.034,color: Colors.black,fontWeight: FontWeight.bold,),
        Container(
          width: w,
          height: h*0.16,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("users").doc(uid).collection("profile").snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot>snapshot){
              if(snapshot.hasData){
                return ListView.builder(
                  // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                 // physics: const FixedExtentScrollPhysics(),
                  itemBuilder: (context,i){
                    QueryDocumentSnapshot x = snapshot.data!.docs[i];
                    return  Container(
                      width: w,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: h*0.1,
                          width: w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Name : "+(name=x['name']).toString()),
                              Text("Email : "+"$email"),
                              Text("Mobile number : "+(mobile=x['mobile']).toString()),
                              Text("address : "+(localaddress=x['address']).toString()),
                            ],),
                        ),
                      ),
                    )  ; //conta
                  },
                  itemCount: snapshot.data!.docs.length,
                );//list
              }
              return const Center(child:  CircularProgressIndicator());
            },//buil
          ),
        ),


    Container(
      margin: EdgeInsets.only(left: w*.69),
        child: ElevatedButton.icon(onPressed: (){
          setState(() {
            if(_value==1) {
              ConfirmAlertDialog(context);
              print("-----------------");
              print("Successfully  ");
              print("-----------------");
            }
            else{
              mass="Is not Available,Try to another Way";
              maasage();
              print("-----------------");
              print("is Not Available ");
              print("-----------------");
            }
          });

          print("--oderconfrimupdate--");
        }, icon:const Icon(Icons.shopping_cart), label:const Text("Confirm"))
    )


      ],

    ),

  ),
),
    );
  }

  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = FlatButton(
      child: const Text("OK"),
      onPressed: () async{
        if(_value==null){

        }
        else {
          FirebaseFirestore.instance.collection("users").doc(uid).collection(
              "OrderAddress").doc("Address").set({
            'address': changeLoct.toString(),
          });
        }
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
      labelText: 'location',
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
        changeLoct=_val;
      },
    );
    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Your location"),
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
  orderConfrimUpdate()async{
    FirebaseFirestore.instance.collection("Manager").doc("OrderCheekup").collection(uid).doc("Info&Amount").collection(DTime).doc("details").set(
        {
          'totalAmount': totalamount.toString(),
          'totalItems':totalItems.toString(),
          'deliverychrages':deliveryChrage.toString(),
          'deliveryAddress':DeliveryAddredd.toString(),
          'name':name.toString(),
          'email':email.toString(),
          'mobile':mobile.toString(),
          'localaddress':localaddress.toString(),
          'uid':uid.toString(),
          'datetime': DTime,
        }
    ) ;
  }


 ConfirmAlertDialog(BuildContext context) {
   // Create button
   Widget ok = ElevatedButton(
     child: const Text("OK"),
     onPressed: ()async{
       setState(() {
         Timer(const Duration(seconds: 2),(){
         //  orderConfrimUpdate();
           Timer(const Duration(seconds: 3),(){
           //  Navigator.pushReplacement(context,
             //    MaterialPageRoute(builder: (context) =>  const UserMain()));
             RemoveOtherData();
             print("Delete");
           //  mass="Successfully ";
         //    maasage();
           });

       });



         });


     },
   );

   Widget No = ElevatedButton(
     child: const Text("Cancel"),
     onPressed: () {
       Navigator.of(context).pop();
     },
   );

   // Create AlertDialog
   AlertDialog alerts = AlertDialog(
     title: const Text("Are you confirmed..!!"),
     // content: Text("This is an alert message."),
     actions: [
       const Text("few you take a minute response for manager,\nplease wait,manager approved your order ",
         style: TextStyle(fontSize: 10,color: Colors.blue),
       ),
       Row(
         children: [
           ok,
           const SizedBox(width: 50),
           No,
         ],
       )

     ],
   );

   // show the dialog
   showDialog(
     context: context,
     builder: (BuildContext context) {
       return alerts;
     },
   );
 }

 RemoveOtherData()async{
   await FirebaseFirestore.instance.collection("users").doc(uid).collection("mycart").doc(uid).delete();
   await FirebaseFirestore.instance.collection("users").doc(uid).collection("amount").doc("totalAmount").delete();
   // mass="delete done";
   // maasage();
   print("--- delete mycart ----");
 }
 maasage(){
   return ScaffoldMessenger.of(context).showSnackBar(
     SnackBar(
       dismissDirection: DismissDirection.startToEnd,
       backgroundColor: Colors.orangeAccent,
       content: Text(mass,
         style: const TextStyle(fontSize: 16, color: Colors.black),
       ),
     ),
   );
 }
}