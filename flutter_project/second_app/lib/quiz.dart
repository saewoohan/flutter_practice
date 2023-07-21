import 'package:flutter/material.dart';
import 'package:second_app/data/questions.dart';
import 'results_screen.dart';
import 'first_Widget.dart';
import 'questions.dart';

class Quiz extends StatefulWidget {
  const Quiz({Key? key}) : super(key: key);

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  List<String> selectedAnswers = [];
  var activeScreen = 'start-screen';

  void switchScreen() {
    setState(() {
      activeScreen = 'questions-screen';
    });
  }

  void chooseAnswer(String answer){
    selectedAnswers.add(answer);

    if(selectedAnswers.length == questions.length){
      setState((){
        activeScreen = 'results-screen';
      });
    }
  }

  void onRestart(){
    setState(() {
      selectedAnswers = [];
    activeScreen = 'questions-screen';
  });
  }

  @override
  Widget build(context) {
    Widget? screenWidget;
    if(activeScreen == 'start-screen'){
      screenWidget = FirstWidget(switchScreen);
    }
    else if(activeScreen == 'results-screen'){
      screenWidget = ResultScreen(onRestart,selectedAnswers);
    }
    else{
      screenWidget = Questions(chooseAnswer);
    }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Quiz App'),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 78, 13, 151),
                Color.fromARGB(255, 107, 15, 168),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: screenWidget,
        ),
      ),
    );
  }
}