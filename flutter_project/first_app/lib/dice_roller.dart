import 'package:flutter/material.dart';
import 'dart:math';

final randomizer = Random();

class DiceRoller extends StatefulWidget{
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() {
    return _DiceRollerState();
  }
}

class _DiceRollerState extends State<DiceRoller> {
  var activeDiceImage ='assets/dice-images/dice-1.png';
  var index = 1;
  @override
  Widget build(context) {
    return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
              Image.asset(activeDiceImage , width: 200),
              const SizedBox(height: 20),
              TextButton(
               onPressed: () {
                setState(() {
                  index = randomizer.nextInt(6)+1;
                  activeDiceImage = 'assets/dice-images/dice-$index.png';
                });
               },
               style: TextButton.styleFrom(
                // padding: const EdgeInsets.only(top: 20,),
                foregroundColor: Colors.white, 
                textStyle: const TextStyle(
                fontSize: 28,
                )),
               child: const Text('Roll Dice'),)
              ],
            );
  }
}