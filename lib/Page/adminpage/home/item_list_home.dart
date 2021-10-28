import 'package:authui/Page/adminpage/itempage/discount_page.dart';
import 'package:authui/Widgets/button.dart';
import 'package:flutter/material.dart';

class ItemPage extends StatefulWidget{
  const ItemPage({Key? key}) : super(key: key);

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  @override
  Widget build(BuildContext context) {

    var h= MediaQuery.of(context).size.height;
    var w =MediaQuery.of(context).size.width;

 return Scaffold(
   appBar: AppBar(
     title: Text("All Item"),
     centerTitle: true,
     leading: Icon(Icons.accessible),
   ),
   body: SingleChildScrollView(
     scrollDirection: Axis.vertical,
     child: SizedBox(
       height: h,
       width: w,
       child: Column(
         children: [
           Text("Discount Foods",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
           const SizedBox(height: 10),
           SizedBox(
             height: 40,
             width: 160,
             child: ButtonWidget(
                 text_color: Colors.white,
                 text:"Discount",
                 text_size: 25,
                 border_size: 3,
                 border_color: Colors.pink,
                 onChange: Discount
             ),
           ),
          const SizedBox(height: 10),
           Text("Category",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
         const  SizedBox(height: 10),
           SizedBox(
             height: 100,
             width: 300,
             child: SingleChildScrollView(
               scrollDirection: Axis.horizontal,
               child: SizedBox(
                 child: Row(
                   children: [
                     ButtonWidget(
                         text_color: Colors.white,
                         text:"Birani",
                         text_size: 25,
                         border_size: 3,
                         border_color: Colors.pink,
                         onChange: Birani
                     ),
                     SizedBox(width: 20,),
                     ButtonWidget(
                         text_color: Colors.white,
                         text:"Burgar",
                         text_size: 25,
                         border_size: 3,
                         border_color: Colors.pink,
                         onChange: Burgar
                     ),
                     SizedBox(width: 20,),
                     ButtonWidget(
                         text_color: Colors.white,
                         text:"Bravage",
                         text_size: 25,
                         border_size: 3,
                         border_color: Colors.pink,
                         onChange: Bravage
                     ),
                   ],
                 ),
               ),
             ),
           ),
           SizedBox(height: 10,),
           Text("Type of people",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
           SizedBox(height: 5,),
           SizedBox(
             height: 100,
             width: 325,
             child: SingleChildScrollView(
               scrollDirection: Axis.horizontal,
               child: Row(
                 children: [
                   ButtonWidget(
                       text_color: Colors.white,
                       text:"baby",
                       text_size: 25,
                       border_size: 3,
                       border_color: Colors.pink,
                       onChange: Baby
                   ),
                   SizedBox(width: 20,),
                   ButtonWidget(
                       text_color: Colors.white,
                       text:"Old Man",
                       text_size: 25,
                       border_size: 3,
                       border_color: Colors.pink,
                       onChange: OldMan
                   ),
                   SizedBox(width: 20,),
                   ButtonWidget(
                       text_color: Colors.white,
                       text:"Diet",
                       text_size: 25,
                       border_size: 3,
                       border_color: Colors.pink,
                       onChange: Diet
                   ),
                 ],
               ),
             ),
           ),


           SizedBox(height: 10,),
           Text("Bands",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
           SizedBox(height: 10,),
           SizedBox(
             height: 100,
             width: 300,
             child: SingleChildScrollView(
               scrollDirection: Axis.horizontal,
               child: Row(
                 children: [
                   ButtonWidget(
                       text_color: Colors.white,
                       text:"ABC",
                       text_size: 25,
                       border_size: 3,
                       border_color: Colors.pink,
                       onChange: ABC
                   ),
                   SizedBox(width: 20,),
                   ButtonWidget(
                       text_color: Colors.white,
                       text:"Cockis",
                       text_size: 25,
                       border_size: 3,
                       border_color: Colors.pink,
                       onChange: Cockis
                   ),
                   SizedBox(width: 20,),
                   ButtonWidget(
                       text_color: Colors.white,
                       text:"Coco Di Mama",
                       text_size: 25,
                       border_size: 3,
                       border_color: Colors.pink,
                       onChange: CocoDiMama
                   ),
                 ],
               ),
             ),
           ),

         ],
       ),
     ),
   ),
 );
  }

  Discount(){

  Navigator.push(context,MaterialPageRoute(builder: (context)=> DiscountPage()));

  }

  Birani (){}

  Burgar(){}

  Bravage(){}

  Baby(){}

  Diet(){}

  OldMan(){}

  ABC(){}

  Cockis(){}

  CocoDiMama(){}
}