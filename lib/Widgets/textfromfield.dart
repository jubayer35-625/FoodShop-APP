import 'package:flutter/material.dart';


class TextFromFieldWigget extends StatelessWidget{
  final String label;
      var maxLength;
  final double border_size;
  TextFromFieldWigget({
    Key?key,
    required this.label,
    required this.maxLength,
    required this.border_size,
}):super(key: key);
  Widget build(BuildContext context)=> TextFormField(
    maxLines: 1,
    maxLength:maxLength,
    decoration: InputDecoration(
        labelText: label,
        hintText: label,
        hintStyle: TextStyle(color:Colors.blue),
        counterText:'',
        border:OutlineInputBorder(borderRadius: BorderRadius.circular(border_size))
    ),
  );

}