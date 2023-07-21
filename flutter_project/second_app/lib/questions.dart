import "package:flutter/material.dart";
import "package:second_app/answer_button.dart";
import "package:second_app/data/questions.dart";
import 'package:google_fonts/google_fonts.dart';

class Questions extends StatefulWidget{
  const Questions(this.onSelectAnswer, {super.key});

  final void Function(String answeer) onSelectAnswer;
  @override
  State<Questions> createState() {
    return _QuestionsState();
  }
}

class _QuestionsState extends State<Questions>{
  var currentQuestionIndex = 0;

  void answerQuestion(String answerQuestion) {
    widget.onSelectAnswer(answerQuestion);
    setState(() {
      currentQuestionIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          
          children: [
          Text(currentQuestion.text,
            style: GoogleFonts.lato(
              color: const Color.fromARGB(255, 190, 104, 219),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          ...currentQuestion.getShuffledAnswers().map((item){
            return Answerbutton(text: item, onTap: () {
              answerQuestion(item);
            }, );
          })
        ],),
      ),
    );
  }
}