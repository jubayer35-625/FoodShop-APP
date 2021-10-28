import 'package:authui/Page/Ads_Page/secondpage.dart';
import 'package:authui/Widgets/button_icon.dart';
import 'package:flutter/material.dart';

class FirstView extends StatefulWidget{
  const FirstView({Key? key}) : super(key: key);
  @override
  State<FirstView> createState() => _FirstViewState();
}
class _FirstViewState extends State<FirstView> {
  @override
  Widget build(BuildContext context) {

   var h = MediaQuery.of(context).size.height;
   var w = MediaQuery.of(context).size.width;

    // TODO: implement build
    return Material(
      child:SingleChildScrollView(
           scrollDirection: Axis.horizontal,
           child: SingleChildScrollView(

             scrollDirection: Axis.vertical,
               child: Column(
                 children: [
                    SizedBox(height:h*0.1,),
                  CircleAvatar(backgroundImage: NetworkImage(img),
                    minRadius:h*0.098,
                    backgroundColor: Colors.pink,
                  ) ,
                   SizedBox(height:h*0.05),
                   SizedBox(
                     width: w,
                     child: Image.network(img2),

                   ),
                  SizedBox(height: h*0.1,),
                   Padding(
                     padding:  EdgeInsets.all(h*.005),
                     child:  Text(
                       "Health food shop.Fresh foods item \nBuy fresh food items "
                     ,
                     style: TextStyle(fontSize: h*0.018),),
                   ),
                    SizedBox(height:h*0.1,),
                 ButtonIconWidget(icon:Icons.arrow_forward,
                     text:" Next  ",
                     onClicked:(){
                       Navigator.pushReplacement(
                         context,
                         PageRouteBuilder(
                           pageBuilder:
                               (context, animation1, animation2) => const SecondView(),
                           transitionDuration: Duration(seconds: 0),
                         ),
                       );
                     },
                     icon_size:h*0.029,
                     text_size:h*0.025,
                     text_color:Colors.white,
                     btn_border_size:h*0.05,
                     btn_border_color:Colors.brown,
                   iconcolor: Colors.brown,
                 ),

                 ],
               ),


           ),
         ),
    );


  }
  var img='https://mir-s3-cdn-cf.behance.net/projects/404/576548105443009.Y3JvcCwyMzAxLDE4MDAsMTQ4LDA.jpg';
  var img2='https://media-exp1.licdn.com/dms/image/C4D1BAQH9d5NADjZBFg/company-background_10000/0/1593517782287?e=2159024400&v=beta&t=bTGS-I9xwZrwvMP3hSxc9P708YkAKKOowuOs-9v5oeg';
}