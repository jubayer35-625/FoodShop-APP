import 'dart:async';
import 'dart:io';

import 'package:authui/API/add_item_discount.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUpdate extends StatefulWidget{
  const ImageUpdate({Key? key}) : super(key: key);

  @override
  State<ImageUpdate> createState() => _ImageUpdateState();
}

class _ImageUpdateState extends State<ImageUpdate> {


  final uid = FirebaseAuth.instance.currentUser!.uid;

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


   // String fileName = file!.path.split('/').last;
  //  print(fileName);
    final destination = 'users/$uid/image_Profile';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    url_img = await snapshot.ref.getDownloadURL();

    print('Download-Link: $url_img');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Photo Choose"),
      ),
      body: Center(
        child: Column(children: [
          SizedBox(height: 30,),
          ElevatedButton.icon(onPressed: (){
            getImage();
          }, icon:Icon(Icons.add_a_photo), label: Text("Select image")),
          SizedBox(height: 30,),
          ElevatedButton.icon(onPressed: (){
            uploadFile();
          }, icon:Icon(Icons.add_a_photo), label: Text("uploading image")),
          SizedBox(height: 10,),
          task != null ? buildUploadStatus(task!) : Container(),
          SizedBox(height: 30,),
          ElevatedButton.icon(onPressed: (){
            Timer(Duration(seconds:2),()async{
              FirebaseFirestore.instance.collection("users").doc(uid).collection("profileimage").doc("img").set({
                'img':url_img.toString(),
              });
               Navigator.pop(context);
            });
          }, icon:Icon(Icons.add_a_photo), label: Text("   Save   ")),
        ],
        ),
      ),
    );
  }
  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
    stream: task.snapshotEvents,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final snap = snapshot.data!;
        final progress = snap.bytesTransferred / snap.totalBytes;
        final percentage = (progress * 100).toStringAsFixed(2);

        return Text("image uploading  "+
            '$percentage %',
          style:const  TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        );
      } else {
        return Container();
      }
    },
  );
}