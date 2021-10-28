import 'package:authui/Page/adminpage/itempage/additem/add_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class DiscountPage extends StatefulWidget{
  const DiscountPage({Key? key}) : super(key: key);

  @override
  State<DiscountPage> createState() => _DiscountPageState();
}

class _DiscountPageState extends State<DiscountPage> {
  var mass;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title:Text("Discount"),
        actions:  [

          Padding(
            padding: EdgeInsets.only(right: 25),
            child: Row(
              children: [
                Text("add to new Item"),
                SizedBox(width: 10,),
                InkWell(child: Icon(Icons.add_circle_outline,size: 35,),onTap: AddItems,),
              ],
            )
          )
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("discount_items").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot>snapshot){
          if(snapshot.hasData){
            return ListView.builder(
             // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context,i){
                QueryDocumentSnapshot x = snapshot.data!.docs[i];
                return Container(
                  width: 100,

                  decoration:BoxDecoration(
                      border: Border.all(
                        width:1,
                      ),
                      borderRadius: BorderRadius.all(
                          Radius.circular(12) //                 <--- border radius here
                      ),
                      color: Colors.deepPurple.withOpacity(.3)
                  ) ,

                    margin: const EdgeInsets.all(15),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [


                        Container(
                          margin: EdgeInsets.only(left: 20,top: 5),
                          // decoration: BoxDecoration(
                          //      border: Border.all(color: Colors.blueAccent)
                          //  ),
                          child:Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            //  CircleAvatar(backgroundImage:NetworkImage(x["imgUrls"]),maxRadius: 70,),
                              ClipRRect(
                                child: Container(
                                  height: 100,
                                  width: 150,
                                  child:Image(image: NetworkImage(x["imgUrls"]),fit: BoxFit.fill),
                                ),
                                borderRadius:BorderRadius.circular(18.0) ,
                              ),
                              Container(margin: EdgeInsets.only(left: 120,top: 20),
                                height: 20,child: ElevatedButton(
                                   child: Text("Delete"),style: ElevatedButton.styleFrom(primary: Colors.red),
                                      onPressed:(){
                                       RemoveIteam(x["productid"]);
                                          }
                                  ),
                                  ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                        Padding(padding: EdgeInsets.only(left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Name : "+ x["foodName"],style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold,)),
                            Text("Title : "+x["title"],style: TextStyle(fontSize: 16,color: Colors.white)),
                            Text("Price : "+x["price"],style: TextStyle(fontSize: 18,color: Colors.black)),
                            Text("Discount of : "+x["discount_%of_price"]+"%",style: TextStyle(fontSize: 18,color: Colors.pink,fontWeight: FontWeight.bold)),
                            Text("Quantity of foods : "+x["quantity"],style: TextStyle(fontSize: 18,color: Colors.black)),
                            SizedBox(height: 10,),
                          ],
                        ),
                        ),

                        //  Icon(Icons.favorite_border,color:Colors.purpleAccent,size: 10,)


                      ],
                    ),



                );
              },
              itemCount: snapshot.data!.docs.length,
            );
          }
          return const Center(child:  CircularProgressIndicator());
        },
      ),
    );
  }
  AddItems(){
    Navigator.push(context,MaterialPageRoute(builder: (context)=> AddItem()));
  }


  GetDocument()async{
  }

 RemoveIteam(String productId)async{
   mass="delete done";
   maasage();
   print("--------- Remove Items -----------");
   print(productId);

   await FirebaseFirestore.instance.collection("discount_items").doc(productId).delete().then((value) =>print("done")).catchError((_){
     print("Error");
   });
 }


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