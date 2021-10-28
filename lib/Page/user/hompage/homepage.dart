import 'package:authui/Page/user/customershowpage/items/discountpage/discount_page.dart';
import 'package:authui/Widgets/button_icon.dart';
import 'package:authui/Widgets/const_box.dart';
import 'package:authui/Widgets/container_design.dart';
import 'package:flutter/material.dart';
class HomeCustomer extends StatefulWidget{
  const HomeCustomer({Key? key}) : super(key: key);

  @override
  State<HomeCustomer> createState() => _HomeCustomerState();
}

class _HomeCustomerState extends State<HomeCustomer> {
  @override
  Widget build(BuildContext context) {

    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor:Colors.deepPurple,
        title: Text("Food shop"),
        actions: [
          Padding(
            padding: EdgeInsets.only(right:w*0.028),
            child: Row(
              children: const [
                Text("Search",style: TextStyle(color: Colors.white)),
                Icon(Icons.search,size: 30,),

              ],
            ),
          )
        ],
        leading: Icon(Icons.add_shopping_cart_sharp,size: 25,),
      ),

      body:SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(w*0.01),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Container(
              margin: EdgeInsets.only(left: w*0.1,right: w*0.1,top: h*0.01),
              height: h*0.05,
              width: w*0.8,
              child: ButtonIconWidget(
                  icon: Icons.add_location_alt_outlined,
                  text:"Your Location choose",
                  onClicked: ChooseLocation,
                  icon_size: 25,iconcolor: Colors.pink,
                  text_size: 14,
                  text_color: Colors.white,
                  btn_border_size: 12,
                  btn_border_color: Colors.pink
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: w*0.1,right: w*0.1,top: w*0.1,bottom: w*0.1),
              height: h*0.2,
              width: w*0.72,
              child:InkWell(child: Image.network(img_discount,),onDoubleTap:(){
                Discount();
              },),
              decoration:const ShapeDecoration (
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  side: BorderSide(color: Colors.white),
                ),
                      shadows: [
                  BoxShadow(
                    color: Colors.pinkAccent,
                    offset: Offset(2.0, 2.0),
                    blurRadius: 20.0,
                    spreadRadius: 10.0,
                  ),
                ],
              ),
            ),

            ContanierDesign(
                hight: h*0.04,
                width: w*0.3,
                color: Colors.pink,
                child: Text("  Category",style: TextStyle(fontSize: 20,color: Colors.white),),
                border_size: 8,
                border_color:Colors.pinkAccent,
                border_width: 3,
                left: 20,
                right: 20
            ),
            SizedBox(height: h*0.02,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child:Row(
                children: [
                  BoxCategory(child:Image.network(baby),color:Colors.brown,border_size: 15,),
                  BoxCategory(child:Image.network(baby),color:Colors.brown,border_size: 15,),
                  BoxCategory(child: Image.network(baby),color:Colors.brown,border_size: 15,),
                  BoxCategory(child: Image.network(baby),color:Colors.brown,border_size: 15,),
                ],
              ) ,
            ),
            SizedBox(height: h*0.01,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child:Row(
                children: [
                  BoxCategory(child:Image.network(baby),color:Colors.brown,border_size: 15,),
                  BoxCategory(child:Image.network(baby),color:Colors.brown,border_size: 15,),
                  BoxCategory(child: Image.network(baby),color:Colors.brown,border_size: 15,),
                  BoxCategory(child: Image.network(baby),color:Colors.brown,border_size: 15,),
                ],
              ) ,
            ),
            SizedBox(height: h*0.02,),
            ContanierDesign(
                hight: h*0.04,
                width: w*0.4,
                color: Colors.pinkAccent,
                child: Text("  Type of People",style: TextStyle(fontSize: 18,color:Colors.white),),
                border_size: 10,
                border_color:Colors.pink,
                border_width: 3,
                left: 20,
                right: 20
            ),


            SizedBox(height: h*0.02,),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child:Row(
                children: [
                  BoxCategory(child:Image.network(baby),color:Colors.brown,border_size: 15,),
                  BoxCategory(child:Image.network(body_builder),color:Colors.brown,border_size: 15,),
                  BoxCategory(child: Image.network(doctor),color:Colors.brown,border_size: 15,),
                ],
              ) ,
            ),
            SizedBox(height: h*0.01,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child:Row(
                children: [
                  BoxCategory(child:Image.network(baby),color:Colors.brown,border_size: 15,),
                  BoxCategory(child:Image.network(baby),color:Colors.brown,border_size: 15,),
                ],
              ) ,
            ),
            SizedBox(height: h*0.02,),
            ContanierDesign(
                hight: h*0.04,
                width: w*0.4,
                color: Colors.orangeAccent,
                child: Text(" Bands of Foods",style: TextStyle(fontSize: 18,color:Colors.white),),
                border_size: 8,
                border_color:Colors.orange,
                border_width: 3,
                left: 20,
                right: 20
            ),
            SizedBox(height: h*0.02,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child:Row(
                children: [
                  BoxCategory(child:Image.network(baby),color:Colors.brown,border_size: 15,),
                  BoxCategory(child:Image.network(body_builder),color:Colors.brown,border_size: 15,),
                  BoxCategory(child: Image.network(doctor),color:Colors.brown,border_size: 15,),
                ],
              ) ,
            ),
            SizedBox(height: h*0.01,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child:Row(
                children: [
                  BoxCategory(child:Image.network(baby),color:Colors.brown,border_size: 15,),
                  BoxCategory(child:Image.network(baby),color:Colors.brown,border_size: 15,),
                ],
              ) ,
            ),

            SizedBox(height: h*0.05,),

          ],
        ),
      ),
    );
  }

  void ChooseLocation(){}
  void Discount(){
    Navigator.push((context),MaterialPageRoute(builder:  (context)=>DiscountCustomerPage()));
  }

  var img_logo='https://upload.wikimedia.org/wikipedia/commons/thumb/f/f9/Food_Network_New_Logo.png/246px-Food_Network_New_Logo.png';
  var img_discount='https://png.pngtree.com/png-clipart/20210704/original/pngtree-orange-striped-fast-food-coupon-banner-png-image_6485849.jpg';
  var baby = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbdhGCu3ZmbeZGI0VbiMhEmPtPSfD9kRkQBQ&usqp=CAU';
  var doctor = 'https://thumbs.dreamstime.com/b/nutritionist-woman-holding-plate-fruits-vegetables-doctor-119007811.jpg';
  var diet = 'https://www.healthifyme.com/blog/wp-content/uploads/2017/02/Best-Indian-Diet-Plan.jpg';
  var body_builder = 'https://www.healthifyme.com/blog/wp-content/uploads/2019/12/BB-diet-plan-2.jpg';
  var drink="https://www.google.com/imgres?imgurl=https%3A%2F%2Ffreepikpsd.com%2Fmedia%2F2019%2F10%2Fthumbs-up-cold-drink-logo-png-4-Transparent-Images-Free.png&imgrefurl=https%3A%2F%2Ffreepikpsd.com%2Fthumbs-up-cold-drink-logo-png-transparent-images-free%2F177762%2F&tbnid=DBbTQXkBZ47A2M&vet=10CDUQMyh9ahcKEwjI5-yVicXzAhUAAAAAHQAAAAAQAg..i&docid=9Xaboj9wO19r-M&w=600&h=448&q=drinks%20logo%20free&hl=en&ved=0CDUQMyh9ahcKEwjI5-yVicXzAhUAAAAAHQAAAAAQAg";





}