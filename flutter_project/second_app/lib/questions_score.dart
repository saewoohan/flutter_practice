
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionsScore extends StatelessWidget{
  const QuestionsScore(this.summaryData, {super.key});

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: summaryData.map((data) {
            Color? color;
            if(data['user_answer'] != data['correct_answer']){
              color = const Color.fromARGB(255, 203, 82, 73);
            }
            else{
              color = const Color.fromARGB(255, 74, 121, 202);
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  color: color,
                  border: Border.all( 
                    width: 1,
                    color: color,
                  ),
                  shape: BoxShape.circle,
                ), 
                child: Text(((data['question_index'] as int)+ 1).toString())),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data['question'] as String,
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                    
                  ),
                  const SizedBox(height: 5,),
                  Text(data['user_answer'] as String,
                  style: GoogleFonts.lato( 
                    color : Colors.white,
                    fontSize: 13,
                  ),
                  ),
                  Text(data['correct_answer'] as String,
                  style: GoogleFonts.lato(
                    color: Color.fromARGB(255, 43, 131, 166),
                    fontSize: 13,
                  ),
                  ),
                ],),
              ),
            ],);
          }).toList(),
        ),
      ),
    );
  }}