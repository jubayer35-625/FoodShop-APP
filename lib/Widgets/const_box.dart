import 'package:flutter/material.dart';
class BoxCategory extends StatelessWidget{
final double border_size;
  final Widget child;
  final Color color;

  const BoxCategory({
    Key? key,
    required this.child,
    required this.border_size,
    required this.color,

  }) : super(key:key);

  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(left: 5,right: 5),
    height: 125,
    width: 150,
    child: child,
    decoration:BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(border_size) , //                 <--- border radius here
      ),
      color: color,
    ) ,
  );
}