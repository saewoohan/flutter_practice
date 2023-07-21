import 'package:flutter/material.dart';

class Answerbutton extends StatelessWidget{
  const Answerbutton({super.key, required this.text, required this.onTap});

  final String text;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
            backgroundColor: const Color.fromARGB(255, 58, 12, 66),
            foregroundColor: const Color.fromARGB(255, 248, 247, 248),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            textStyle: const TextStyle(
              color: Colors.white,
            ),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            ),);
  }

}