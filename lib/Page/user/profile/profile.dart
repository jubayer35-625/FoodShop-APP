import 'dart:async';
import 'dart:io';

import 'package:authui/API/add_item_discount.dart';
import 'package:authui/Page/user/customer_process/customer_account_iusse/login.dart';
import 'package:authui/Page/user/profile/update_profile/imageupdate.dart';
import 'package:authui/Page/user/profile/update_profile/updateprofile.dart';
import 'package:authui/Widgets/button_icon.dart';
import 'package:authui/Widgets/text_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget{
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {



  final uid = FirebaseAuth.instance.currentUser!.uid;
  final email = FirebaseAuth.instance.currentUser!.email;
  final creationTime = FirebaseAuth.instance.currentUser!.metadata.creationTime;

  User? user = FirebaseAuth.instance.currentUser;

  UploadTask? task;
  ImagePicker image = ImagePicker();
  File? file_img;
  var url_img;
  String url="";
  File? file;
  //File? file_img;
  Future getImage() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
  }


  Future uploadFile() async {

    if (file == null) return;


    String fileName = file!.path.split('/').last;
    print(fileName);
    final destination = 'image_Profile/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    url_img = await snapshot.ref.getDownloadURL();

    print('Download-Link: $url_img');
  }


  verifyEmail() async {
    if (user != null && !user!.emailVerified) {
      await user!.sendEmailVerification();
      print('Verification Email has benn sent');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            'Verification Email has benn sent',
            style: TextStyle(fontSize: 18.0, color: Colors.black),
          ),
        ),
      );
    }
  }





  @override
  Widget build(BuildContext context) {

    FixedExtentScrollController fixedExtentScrollController =
    new FixedExtentScrollController();

    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: const Text("profile"),centerTitle: true,
      leading: const Icon(Icons.account_circle_outlined),
          actions: [
            Padding(padding: const EdgeInsets.only(right: 20,top: 5,bottom: 5),
            child: ElevatedButton(
                 onPressed: () async => {
                 await FirebaseAuth.instance.signOut(),
                 Navigator.pushAndRemoveUntil(
                     context,
                    MaterialPageRoute(
                     builder: (context) => const Login(),
                    ),(route) => false)
                  },
                  child: const Text('Logout'),
                  style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
                  )
              ,),
        ],
      ),
      body:SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child:Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: h*0.2,
                width: w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50),bottomRight: Radius.circular(50)),
                    border: Border.all(
                      width:5,
                        color: Colors.blue.withOpacity(.1)
                    ),
                    color: Colors.blue.withOpacity(.3),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: h*0.15,
                      width: w,
                      margin: EdgeInsets.only(left: w*0.35),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: h*0.13,
                              width:w*0.25,
                             // color: Colors.black,
                              child:StreamBuilder(
                                stream:  FirebaseFirestore.instance.collection("users").doc(uid).collection("profileimage").snapshots(),
                                builder: (context, AsyncSnapshot<QuerySnapshot>snapshot){
                                  if(snapshot.hasData){
                                    return ListView.builder(
                                      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                      // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                                      itemBuilder: (context,i){
                                        QueryDocumentSnapshot x = snapshot.data!.docs[i];
                                        return CircleAvatar(maxRadius: w*0.14,backgroundImage: NetworkImage(x["img"]),) ; //conta
                                      },
                                      itemCount: snapshot.data!.docs.length,
                                    );//list
                                  }
                                  return const Center(child:  CircularProgressIndicator());
                                },//buil
                              ),
                          ),
                          InkWell(
                            child: Container(
                              height: 20,
                                width: 20,
                                child: Icon(Icons.add_a_photo_outlined)),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageUpdate()));
                            },
                          ),
                        ],


                      ),
                    ),
                    Container(
                        height: 20,
                        width: 350,
                       // color: Colors.black,
                        child:StreamBuilder(
                          stream:  FirebaseFirestore.instance.collection("users").doc(uid).collection("profile").snapshots(),
                          builder: (context, AsyncSnapshot<QuerySnapshot>snapshot){
                            if(snapshot.hasData){
                              return ListView.builder(
                                itemBuilder: (context,i){
                                  QueryDocumentSnapshot x = snapshot.data!.docs[i];
                                  return Center(
                                    child: Text(x['name']),
                                  ) ; //conta
                                },
                                itemCount: snapshot.data!.docs.length,
                              );//list
                            }
                            return const Center(child:  CircularProgressIndicator());
                          },//buil
                        ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: h*0.02,),
              Container(
                height: 40,
                width: 500,
                child: Row(
                  children: [
                    TextWidget(text: "Your Information : ",size:w*0.034,color: Colors.black,fontWeight: FontWeight.bold,),
                    SizedBox(width: w*0.4,),
                    ButtonIconWidget(text: "change", text_color: Colors.pink, text_size: w*0.037,
                      icon: Icons.edit,icon_size:w*0.042,iconcolor: Colors.white,
                      btn_border_color: Colors.white,btn_border_size: 8,
                      onClicked: (){
                     setState(() {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateProfile()));
                        print("enter");
                     });

                      //  showAlertDialog(context);
                      },
                    ),

                  ],
                ),
              ),


              Container(
                width: w,
                height: h*0.11,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("users").doc(uid).collection("profile").snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot>snapshot){
                    if(snapshot.hasData){
                      return ListView.builder(
                        // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                        physics: FixedExtentScrollPhysics(),

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
                                    Text("Name : "+x['name']),
                                    Text("Email : "+"$email"),
                                    Text("Mobile number : "+x['mobile']),
                                    Text("address : "+x['address']),
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



              ButtonIconWidget(icon:Icons.history,
                  text:"History",
                  onClicked: (){},
                  icon_size: 25,
                  text_size: 14,
                  text_color: Colors.black,
                  btn_border_size:0,
                  btn_border_color:Colors.white,
                iconcolor: Colors.black,
              ),
              Container(
                height: h*0.5,
                width: w,
              //  color: Colors.brown,
              )



            ],
          ),
        ),
      ) ,
    );
  }
}