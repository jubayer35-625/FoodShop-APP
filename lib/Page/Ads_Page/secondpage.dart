import 'package:authui/Widgets/button_icon.dart';
import 'package:authui/Widgets/text_widgets.dart';
import 'package:flutter/material.dart';

import '../user/customer_process/customer_account_iusse/login.dart';
class SecondView extends StatefulWidget{
  const SecondView({Key? key}) : super(key: key);
  @override
  State<SecondView> createState() => _FirstViewState();
}
class _FirstViewState extends State<SecondView> {
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
              SizedBox(height: h*0.09,),
              CircleAvatar(backgroundImage: NetworkImage(img),
                minRadius:h*0.09,
                backgroundColor: Colors.pink,
              ) ,
               TextWidget(text:"Quick Order Now.\n    Don't Miss  ",
                  size: h*0.029, color:Colors.deepPurple,
                  fontWeight: FontWeight.bold),
               SizedBox(height:h*0.05),
              SizedBox(
                width: w,
                child: Image.network(img2),

              ),
              SizedBox(height: h*0.01,),
               Padding(
                padding:  EdgeInsets.all(h*0.031),
                child:  Text(
                  "Special news for Baby Foods. \nEnjoy all Family member or Friends. "
                  ,
                  style: TextStyle(fontSize: h*0.025),),
              ),
                SizedBox(height: h*0.031,),
              ButtonIconWidget(icon:Icons.arrow_forward,
                  text:"Let's Go ",
                  onClicked:(){
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder:
                            (context, animation1, animation2) => const Login(),
                        transitionDuration: Duration(seconds: 0),
                      ),
                    );
                  },
                  icon_size:h*0.025,iconcolor: Colors.brown,
                  text_size: h*.025, text_color:Colors.white,
                  btn_border_size:h*0.021,
                  btn_border_color:Colors.brown),

            ],
          ),


        ),
      ),
    );

  }
  var img='https://2rdnmg1qbg403gumla1v9i2h-wpengine.netdna-ssl.com/wp-content/uploads/sites/3/2021/01/foodMood-182175784_770x533-650x428.jpg';
  var img2='https://t3.ftcdn.net/jpg/03/35/51/06/360_F_335510693_HY7mLg3ARdLccKoXk3m66NLDpJRJh51p.jpg';
}