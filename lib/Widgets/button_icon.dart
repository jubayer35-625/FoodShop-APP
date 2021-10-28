import 'package:flutter/material.dart';

class ButtonIconWidget extends StatelessWidget{
  final IconData icon;
   final double icon_size;
   final double text_size;
  final String text;
  final VoidCallback onClicked;
  final Color text_color;
  final double btn_border_size;
  final Color btn_border_color;
  final Color iconcolor;


  const ButtonIconWidget({
    Key? key,
    required this.icon,
    required this.text,
    required this.onClicked,
    required this.icon_size,
    required this.text_size,
    required this.text_color,
    required this.btn_border_size,
    required this.btn_border_color, required this.iconcolor,
}) : super(key: key);

@override
  Widget build(BuildContext context) => ElevatedButton(
    onPressed: onClicked,
    child: buildContent(),
  style: ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(btn_border_size),
              side: BorderSide(color:btn_border_color)
          )
      ),
  ),
);
Widget buildContent() => Row(
  mainAxisSize: MainAxisSize.min,
  children:  [

    Text(text, style:TextStyle(fontSize:text_size, color:text_color),),
    Icon(icon,size:icon_size,color: iconcolor),
  ],

);
}