import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DiscountCustomerPage  extends StatefulWidget{
  const DiscountCustomerPage({Key? key}) : super(key: key);

  @override
  State<DiscountCustomerPage> createState() => _DiscountCustomerPageState();
}

class _DiscountCustomerPageState extends State<DiscountCustomerPage> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  var mass;
  @override
  Widget build(BuildContext context) {
    var h =MediaQuery.of(context).size.height;
    var w =MediaQuery.of(context).size.width;

    // TODO: implement build
    return Scaffold(
      backgroundColor:Colors.blue.withOpacity(.3),
      appBar: AppBar(title: const Text("Discount & Offers"),
      toolbarHeight: w*0.08,
      centerTitle: true,
      ),


      body:StreamBuilder(

        stream: FirebaseFirestore.instance.collection("discount_items").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot>snapshot){
          if(snapshot.hasData){
            return Padding(
              padding: const EdgeInsets.all(0.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),

                itemBuilder: (context,i){
                  QueryDocumentSnapshot x = snapshot.data!.docs[i];
                  return Container(
                    decoration:BoxDecoration(
                        border: Border.all(
                          width:1.5,
                          color: Colors.pink
                        ),
                        borderRadius:const BorderRadius.all(
                            Radius.circular(15),
                        ),
                        color: Colors.pink.withOpacity(.7)
                    ) ,

                    margin: EdgeInsets.all(w*0.011),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [


                        Container(
                          margin:EdgeInsets.only(left: w*0.06,top:w*0.01),
                          child:Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //  CircleAvatar(backgroundImage:NetworkImage(x["imgUrls"]),maxRadius: 70,),
                              ClipRRect(
                                child: SizedBox(
                                  height: h*0.09,
                                  width: w*0.35,
                                  child:Image(image: NetworkImage(x["imgUrls"]),fit: BoxFit.fill),
                                ),
                                borderRadius:BorderRadius.circular(18.0) ,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: h*0.01,),
                        Padding(padding:const EdgeInsets.only(left:5,bottom: 2),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                height:h*0.11,
                                width: w*0.31,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(x["foodName"],style:const TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold,)),
                                    Text(x["title"],style:const TextStyle(fontSize:11,color: Colors.white)),
                                    Text("Price : "+x["price"]+"৳",style:const TextStyle(fontSize: 12,color: Colors.white)),
                                    Text("Discount of : "+x["discount_%of_price"]+"%",style:const TextStyle(fontSize: 11,color: Colors.white)),
                                    Text("QTY : "+x["quantity"],style:const TextStyle(fontSize:9,color: Colors.orange)),
                                  ],
                                ),
                              ),
                             const SizedBox(width:1,),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12)
                                ),
                                child:Center(
                                  child: InkWell(onTap: ()async{

                                    print("add to cart click ");
                                   mass="add to card done ";
                                   maasage();
                                    FirebaseFirestore.instance.collection("users").doc(uid).collection("mycart").doc(uid).collection("mycart").doc(x['productid']).set({
                                      'imgUrls':x["imgUrls"],
                                      'foodName': x["foodName"],
                                      'title': x["title"],
                                      'price':x["price"],
                                      'quantity':x["quantity"],
                                      'discount_%of_price':x["discount_%of_price"],
                                      'productid':x['productid'],
                                      'valueitems':1.toString(),
                                    });
                                  },
                                    child: SizedBox(
                                      height: h*0.03,
                                      width: w*0.14,
                                      child: Row(
                                        children: [
                                          Icon(Icons.add_circle,size: w*0.04,color: Colors.red,),
                                          Text("Add",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: w*0.035),)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                             //  SizedBox(height: 5,),
                            ],
                          ),
                        ),

                      ],
                    ),
                  );
                },
                itemCount: snapshot.data!.docs.length,
              ),
            );
          }
          return const Center(child:  CircularProgressIndicator(backgroundColor:Colors.pink,strokeWidth: 4.0,));
        },
      ),



    );
  }
  maasage(){
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        dismissDirection: DismissDirection.startToEnd,
        backgroundColor: Colors.orangeAccent,
        content: Text(
          mass,
          style: const TextStyle(fontSize: 16, color: Colors.black),
        ),
      ),
    );
  }
}