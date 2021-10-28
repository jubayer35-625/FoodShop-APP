import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget{
  final String text;
  final double text_size;
  final Color text_color;
  final double border_size;
  final Color border_color;
  final VoidCallback onChange;
  const ButtonWidget({
    Key? key,
    required this.text_color,
    required this.text,
    required this.text_size,
    required this.border_size,
    required this.border_color,
    required this.onChange,

}) :super(key: key);

  Widget build(BuildContext context) =>  ElevatedButton(
    onPressed: onChange,
    child: Text(text,style: TextStyle(fontSize: text_size,color: text_color)),
    style: ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(border_size),
              side: BorderSide(color:border_color)
          ),
      ),
    ),

  );
}