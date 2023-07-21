import 'package:flutter/material.dart';
import 'package:second_app/data/questions.dart';
import 'questions_score.dart'; 

class ResultScreen extends StatelessWidget{
  const ResultScreen(this.onRestart, this.chosenAnswers, {super.key});

  final List<String> chosenAnswers;
  final void Function() onRestart;

  List<Map<String, Object>> getSummaryData(){
    final List<Map<String, Object>> summary = [];

    for(int i = 0 ; i<chosenAnswers.length; i++){
      summary.add({
        'question_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0],
        'user_answer': chosenAnswers[i],
      });
    }

    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final summaryData = getSummaryData();
    final numTotalQuestions = questions.length;
    final numCorrectQuestions = summaryData.where((data) {
      return data['user_answer'] == data['correct_answer'];
    }).length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('You answered $numCorrectQuestions out of $numTotalQuestions questions correctly!'),
          const SizedBox(height: 30),
          QuestionsScore(summaryData),
          const SizedBox(height: 30,),
          OutlinedButton.icon(
            onPressed: () {
              onRestart();
            },
            icon: const Icon(Icons.restart_alt),
            label: const Text('Restart Quiz!')
          ,)
      ],) 
      )
    );
  }

}