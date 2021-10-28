import 'package:authui/Page/user/order_confrimation/orderconfrim.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyCartPage extends StatefulWidget{
  const MyCartPage({Key? key}) : super(key: key);

  @override
  State<MyCartPage> createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {

  final uid = FirebaseAuth.instance.currentUser!.uid;
var mass,value,qnty,xv;
 var current=0.0;
 var  discount=0.0 ;
 var sum=0.0;
 var dsum=0.0,dtotal=0;
 var percentage=0.0;
 var total=0,items=0.0,count=0.0,qty=0,price=0.0,offers,dev=0;
 var a=0,b=0,c="+",aa,bb,cc=0,dd=0.0;

   @override
  void initState()  {
   FirebaseFirestore.instance.collection("users").doc(uid).collection("mycart").doc(uid).collection("mycart").get().then(
          (querySnapshot) {
            querySnapshot.docs.forEach((result) {

              current=double.parse(result.data()['price']);
              percentage=double.parse(result.data()['discount_%of_price']);
              items=double.parse(result.data()['valueitems']);
              count = count + items;
              setState(() {
              CalcuateAmount(current, percentage, items);
              });

            });
      },
    );
   super.initState();
  }

  CalcuateAmount(var price,var offer,var valueOfitems) async {
   //  count =valueOfitems.toInt();

    dev=60;
    if(offer>0){
      discount =((offer*price )/100);
      sum = sum + ((price - discount)*valueOfitems);
        total =sum.toInt();
     // count++;
    }
    else{
      sum = sum + ( price  *  valueOfitems);
        total =sum.toInt();
     // count++;
    }
    cc=count.toInt();
    return await  FirebaseFirestore.instance.collection("users").doc(uid).collection("amount").doc("totalAmount").set({
      'totalAmount':total.toString(),
      'items':cc.toString(),
      'delivary':dev.toString(),
    });
  }


  testing(var a,var b , var c) async {
     if(c=="+"){
       count++;
       if(b>0){
         discount = ((b*a )/100);
         sum = sum+(a-discount);
         total = sum.toInt();
       }else{
         sum = sum+a ;
         total = sum.toInt();
       }
     }
     else{
       count--;
       if(b>0){
         discount = ((b*a)/100);
         sum = sum-(a-discount);
         total = sum.toInt();
       }else{
         sum = sum-a ;
         total = sum.toInt();
       }
     }
     cc=count.toInt();
     return await  FirebaseFirestore.instance.collection("users").doc(uid).collection("amount").doc("totalAmount").set({
       'totalAmount':total.toString(),
       'items':cc.toString(),
       'delivary':dev.toString(),
     });

  }

  AmountDeleteietems(var a, var b,var cv) async {
     print("---");
     print(total);
     print("---");
    count = count - cv;
    if(b>0){
    discount = ((b*a )/100);
    dsum = (a-discount);
    dsum= dsum*cv;
    dtotal = total- dsum.toInt();
    }else{
    dsum = a;
    dsum=dsum*cv;
    dtotal = total- dsum.toInt();
    }
    cc=count.toInt();
    print("-----");
    print(dsum);
     print("- Delete Done amount -");
     print(dtotal);
     print("-------");

    return await  FirebaseFirestore.instance.collection("users").doc(uid).collection("amount").doc("totalAmount").set({
      'totalAmount':dtotal.toString(),
      'items':cc.toString(),
      'delivary':dev.toString(),
    });
  }


  @override
  Widget build(BuildContext context) {


    FixedExtentScrollController fixedExtentScrollController =
    FixedExtentScrollController();


    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.purple.withOpacity(.3),
      appBar: AppBar(title: const Text("MyCart"),centerTitle: true,
      leading: Icon(Icons.add_shopping_cart_sharp),),
      body: Column(
        children: [
          Container(
            height: 570,
            width: 400,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection("users").doc(uid).collection("mycart").doc(uid).collection("mycart").snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot>snapshot){
                if(snapshot.hasData){
                  return ListView.builder(
                    // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                    physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    itemBuilder: (context,i){
                      QueryDocumentSnapshot x = snapshot.data!.docs[i];
                      return Container(
                        width: 80,

                        decoration:BoxDecoration(
                            border: Border.all(
                              width:1,
                            ),
                            borderRadius: const BorderRadius.all(
                                Radius.circular(12) //                 <--- border radius here
                            ),
                            color: Colors.blue.withOpacity(.3)
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
                                      height: 80,
                                      width: 130,
                                      child:Image(image: NetworkImage(x["imgUrls"]),fit: BoxFit.fill),
                                    ),
                                    borderRadius:BorderRadius.circular(18.0) ,
                                  ),
                                  Container(margin: EdgeInsets.only(left: 120,top: 10),
                                    height: 20,child: ElevatedButton(
                                        child: const Text("Cancel"),style: ElevatedButton.styleFrom(primary: Colors.red),
                                        onPressed:(){
                                          RemoveIteam(x["productid"]);

                                          aa=double.parse(x["price"]);
                                          bb=double.parse(x["discount_%of_price"]);
                                          dd=double.parse(x["valueitems"]);

                                        AmountDeleteietems(aa, bb,dd ) ;
                                        }
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Padding(padding: const EdgeInsets.only(left: 20),
                              child: Row(
                                children: [
                                  Container(
                                    height: 60,
                                    width: 200,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Name : "+ x["foodName"],style: const TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.bold,)),
                                        Text("Price : "+x["price"],style: const TextStyle(fontSize: 12,color: Colors.black)),
                                        Text("Discount of : "+x["discount_%of_price"]+"%",style:const TextStyle(fontSize: 12,color: Colors.white)),
                                        const SizedBox(height: 10,),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin:const EdgeInsets.only(bottom: 15),
                                    child: IconButton(
                                        icon:const Icon(Icons.minimize_sharp,size: 35,),
                                        onPressed: ()async{
                      print(x['valueitems']);
                      value=x["valueitems"].toString();
                      xv=int.parse(value);
                      if(xv>1) {
                      xv--;
                      aa=double.parse(x["price"]);
                      bb=double.parse(x["discount_%of_price"]);
                      testing(aa, bb, "-");
                      print(x["productid"]);
                      await  FirebaseFirestore.instance.collection("users").doc(uid).collection("mycart").doc(uid).collection("mycart").doc(x["productid"]).set({
                      'valueitems':xv.toString(),
                      'imgUrls':x["imgUrls"],
                      'foodName': x["foodName"],
                      'title': x["title"],
                      'price':x["price"],
                      'quantity':x["quantity"],
                      'discount_%of_price':x["discount_%of_price"],
                      'productid':x["productid"],
                      });
                      }

                      },),),
                                  SizedBox( width: 2,),
                                  SizedBox(height:30,width:40,child: Text(x["valueitems"],style: TextStyle(fontSize: 25),)),
                                  SizedBox( width: 2,),
                                  IconButton(
                                    icon:Icon(Icons.add_circle),
                                    onPressed: ()async{
                                      qnty =int.parse(x["quantity"]);
                                       // print(x['valueitems']);
                                        value=x["valueitems"].toString();
                                        xv=int.parse(value);
                                        if(xv>=1) {
                                          if(xv<(qnty+1))
                                            {
                                              xv++;
                                              aa=double.parse(x["price"]);
                                              bb=double.parse(x["discount_%of_price"]);
                                              testing(aa,bb,c);
                                              print("--------");
                                              print(xv);
                                              print("--------");

                                              FirebaseFirestore.instance.collection("users").doc(uid).collection("mycart").doc(uid).collection("mycart").doc(x["productid"]).set({
                                                'valueitems':xv.toString(),
                                                'imgUrls':x["imgUrls"],
                                                'foodName': x["foodName"],
                                                'title': x["title"],
                                                'price':x["price"],
                                                'quantity':x["quantity"],
                                                'discount_%of_price':x["discount_%of_price"],
                                                'productid':x["productid"],
                                              });
                                            }
                                        }
                                 },),
                                ],
                              ),
                            ),
                            //  Icon(Icons.favorite_border,color:Colors.purpleAccent,size: 10,)

                          ],
                        ),


                      ) ;
                    },
                    itemCount: snapshot.data!.docs.length,
                  );
                }
                return const Center(child:  CircularProgressIndicator());
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(50),topRight: Radius.circular(50)),
              border: Border.all(
               // width:3,
                color: Colors.white.withOpacity(0.8)
              ),
              color: Colors.white.withOpacity(.3)
            ),
            height: 136.5,
           width: 500,
          //  color: Colors.pink,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection("users").doc(uid).collection("amount").snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot>snapshot){
                if(snapshot.hasData){
                  return ListView.builder(
                    // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
               //     physics: FixedExtentScrollPhysics(),
                    itemBuilder: (context,i){
                      QueryDocumentSnapshot x = snapshot.data!.docs[i];
                      return Column(
                        children: [
                          Text("Total Items : "+x['items']),
                        Text("Delivary Charages : "+x['delivary']),
                          Text("Total Amount : "+x['totalAmount'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                          SizedBox(height: 10,),
                          ElevatedButton.icon(onPressed: (){

                            Navigator.push(context, MaterialPageRoute(builder:(context)=>OrderConfrimation()));
                          }, icon:Icon(Icons.add_shopping_cart) , label:Text("Confrim"))
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
        ],
      ),

    );
  }
  RemoveIteam(String productId)async{
   // mass="remove item";
   // maasage();
    print("--------- Remove Items -----------");
    print(productId);

    await FirebaseFirestore.instance.collection("users").doc(uid).collection("mycart").doc(uid).collection("mycart").doc(productId).delete().then((value) =>print("done")).catchError((_){
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
          style: const TextStyle(fontSize: 18.0, color: Colors.black),
        ),
      ),
    );
  }

}