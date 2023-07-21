import 'package:flutter/material.dart';
// ignore: must_be_immutable
class TextContanier extends StatelessWidget{
  const TextContanier(this.text,{super.key});
  final String text;

  @override
  Widget build(context) {
    return Text(text, style: const TextStyle(
              color: Colors.white, 
              fontSize: 28.6,)  
              );
  }
}