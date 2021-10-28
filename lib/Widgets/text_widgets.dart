import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget{
  final String text;
  final double size;
  final Color color;
  final FontWeight fontWeight;
  const TextWidget({
Key? key,
    required this.text,
    required this.size,
    required this.color,
    required this.fontWeight
  }) :super(key: key);

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: TextStyle(
        fontSize: size,
        color:color,
        fontWeight: fontWeight ),
  );

}