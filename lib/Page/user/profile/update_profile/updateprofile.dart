import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UpdateProfile extends StatelessWidget{
  final db = FirebaseFirestore.instance;
  var name="";
  var email="";
  var number;
  var address="";

  final uid = FirebaseAuth.instance.currentUser!.uid;
  final emai = FirebaseAuth.instance.currentUser!.email;

  UpdateProfile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("updating Informations"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          height: h,
          width: w,

          child: Padding(
            padding: EdgeInsets.only(top: 20,left: 30,right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizedBox(height: 20,),
                SizedBox(
                  height: 40,
                  width: 250,
                  child: TextFormField(  decoration: InputDecoration(
                      labelText:'Name' ,
                      hintStyle: TextStyle(color:Colors.blue),
                      counterText:'',
                      border:OutlineInputBorder(borderRadius: BorderRadius.circular(12))
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
                      name=_val;
                    },
                  ),
                ),
                SizedBox(height: 20,),

                SizedBox(
                  height: 40,
                  width: 250,
                  child: TextFormField(  decoration: InputDecoration(
                      labelText:'mobile number' ,
                      hintStyle: TextStyle(color:Colors.blue),
                      counterText:'',
                      border:OutlineInputBorder(borderRadius: BorderRadius.circular(12))
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
                      number=_val;
                    },
                  ),
                ),
                SizedBox(height: 20,),


                SizedBox(
                  height: 40,
                  width: 300,
                  child: TextFormField(  decoration: InputDecoration(
                      labelText:'address' ,
                      hintStyle: TextStyle(color:Colors.blue),
                      counterText:'',
                      border:OutlineInputBorder(borderRadius: BorderRadius.circular(12))
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
                      address=_val;
                    },

                  ),
                ),
                SizedBox(height: 20,),


                SizedBox(height: 30,),
                Container(
                  width: 80,
                  margin: EdgeInsets.only(left: 50),
                  height: 30,child: ElevatedButton(
                  onPressed:(){
                    FirebaseFirestore.instance.collection("users").doc(uid).collection("profile").doc("information").set({
                      'name':name.toString(),
                      'mobile':number.toString(),
                      'address':address.toString(),
                    });

                    Navigator.pop(context);
                  },
                  child: Text("Save"),
                ),),
              ],
            ),
          ),
        ),
      ),
    );

  }

}