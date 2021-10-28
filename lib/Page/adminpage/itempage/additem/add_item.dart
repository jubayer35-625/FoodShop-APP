import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:authui/API/add_item_discount.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddItem extends StatefulWidget{
  const AddItem({Key? key}) : super(key: key);

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {

  String? basenam;
  UploadTask? task;
  File? file;
  final db = FirebaseFirestore.instance;
  String foodname="";
  String title="";
  var price="";
  var discount="";
  var quantitiy;
  var mass="";
  ImagePicker image = ImagePicker();
  File? file_img;
  var url_img;
  String url="";
   //uploadImg() async{
    //   FilePickerResult? result = await FilePicker.platform.pickFiles();
    // File pick = File(result!.files.single.path.toString());
    // var file = pick.readAsBytesSync();
   // if (file == null) return;
   // String name = DateTime.now().microsecondsSinceEpoch.toString();
    // image
   // var imageFile = FirebaseStorage.instance.ref().child(name).child("/.jpg");
   // UploadTask taskimg = imageFile.putFile(file_img!);
   // TaskSnapshot image_snapshot = await taskimg;

   // if (task == null) return;

   // final snapshot = await task!.whenComplete(() {});
  //  url_img = await  image_snapshot.ref.getDownloadURL();

  //}
  //Future getImage() async{
   // var img = await image.pickImage(source: ImageSource.gallery);
   // setState(() {
  //    file_img = File(img!.path);
  //  });
  //}

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
    final destination = 'image_foods/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    url_img = await snapshot.ref.getDownloadURL();

    print('Download-Link: $url_img');
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Add to new Item'),
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
                foodname=_val;
              },
            ),
          ),
          SizedBox(height: 20,),

          SizedBox(
            height: 40,
            width: 250,
            child: TextFormField(  decoration: InputDecoration(
                labelText:'title' ,
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
              title=_val;
              },
            ),
          ),
          SizedBox(height: 20,),


          SizedBox(
            height: 40,
            width: 100,
            child: TextFormField(  decoration: InputDecoration(
                labelText:'price' ,
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
                price=_val;
              },

            ),
          ),
          SizedBox(height: 20,),

          SizedBox(
            height: 40,
            width: 100,
            child: TextFormField(  decoration: InputDecoration(
                labelText:'quantity' ,
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
                quantitiy=_val;
              },

            ),
          ),
          SizedBox(height: 20,),
        SizedBox(
          height: 40,
          width: 200,
          child: TextFormField(  decoration: InputDecoration(
              labelText:'Discount of % ' ,
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
              discount=_val;
            },

          ),
        ),
        SizedBox(height: 40,),
          SizedBox(
            height: 40,
            child: Row(
              children:  [
                const Text("Select image ",
                  style: TextStyle(fontSize: 16,color: Colors.blueAccent),
                ),
                const SizedBox(width:5,),
                IconButton(
                  icon:Icon(Icons.add_a_photo_outlined,),
                  onPressed: (){
                    getImage();
                  },
                ),
              ],
            ),
          ),
        const SizedBox(height: 25),

        InkWell(
          child: Row(
            children: const [
              Text("uploading Image ",
                style: TextStyle(fontSize: 16,color: Colors.blueAccent),
              ),
              Icon(Icons.cloud_upload_outlined),
            ],
          ),
          onTap:uploadFile ,
        ),
        const SizedBox(height: 20),
        task != null ? buildUploadStatus(task!) : Container(),
        SizedBox(height: 30,),
        Container(
          margin: EdgeInsets.only(left: 50),
          height: 30,child: ElevatedButton(
          onPressed:  Uploading
          , child: Text("Save"),
        ),),
      ],
    ),
      ),
        ),
      ),
    );
  }
  Uploading()async{


    if(file == null) {
      mass="can't fill up";
      maasage();
    }if(file!=null){
if(url_img!=null){

var random;
random=Random(1000).nextInt(100000).toString();
var time=Timestamp.now();
var mils=time.microsecondsSinceEpoch;
random=random+mils.toString();
print(random);
 // FirebaseFirestore.instance.collection("discount_items").
  FirebaseFirestore.instance.collection("discount_items").doc(random).set({
    'imgUrls':url_img,
    'foodName':foodname.toString(),
    'title':title.toString(),
    'price':price.toString(),
    'quantity':quantitiy.toString(),
    'discount_%of_price':discount.toString(),
    'productid':random,
    'valueitems':1.toString(),
  });

  Timer(Duration(seconds: 3),(){
    mass="  successful ";
    maasage();
    Navigator.pop(context);
  });

}else{
  mass="Please upload image first";
}

    }else{
      mass=" error ";
    }

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

maasage(){
  return ScaffoldMessenger.of(context).showSnackBar(
     SnackBar(
       dismissDirection: DismissDirection.startToEnd,
      backgroundColor: Colors.orangeAccent,
      content: Text(
        mass,
        style: TextStyle(fontSize: 18.0, color: Colors.black),
      ),
    ),
  );
}


}