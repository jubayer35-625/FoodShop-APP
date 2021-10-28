import 'package:flutter/material.dart';
class ContanierDesign extends StatelessWidget{
  final double left,right;
  final double hight;
  final double width;
  final Widget child;
  final double border_size;
  final Color border_color;
  final Color color;
  final double border_width;

  const ContanierDesign({
    Key? key,
    required this.hight,
    required this.width,
    required this.child,
    required this.border_size,
    required this.border_color,
    required this.border_width,
    required this.left,
    required this.right, required this.color,

  }) : super(key:key);

  @override
  Widget build(BuildContext context) => Container(
    margin: EdgeInsets.only(left: left,right: right),
    height: hight,
    width: width,
    child: child,
    decoration:BoxDecoration(
        border: Border.all(
          width:border_width,
          color:border_color
        ),
        borderRadius: BorderRadius.all(
            Radius.circular(border_size) , //                 <--- border radius here
        ),
        color: color,

    ) ,
  );
}