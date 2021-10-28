import 'package:flutter/material.dart';

class ContanierWidget extends StatelessWidget{
  final double hight;
  final double width;
  final Widget child;
  final double border_size;
  final Color border_color;
  final double border_width;

   ContanierWidget({
    Key? key,
    required this.hight,
    required this.width,
    required this.child,
    required this.border_size,
    required this.border_color,
    required this.border_width,


}) : super(key:key);

  @override
  Widget build(BuildContext context) => Container(
    height: hight,
    width: width,
    child: child,
    decoration:BoxDecoration(
      border: Border.all(
          width:border_width,
      ),
      borderRadius: BorderRadius.all(
          Radius.circular(border_size) //                 <--- border radius here
      ),
        color: border_color
    ) ,
  );
}