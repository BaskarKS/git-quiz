import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:git_quiz/question.dart';
import 'package:git_quiz/question_widget.dart';
import 'package:git_quiz/questions_provider.dart';

import 'answer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    debugPaintSizeEnabled = false; // show widget bounds

    return MaterialApp(
      title: 'Git Quiz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Git Quiz'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final questionsProvider = QuestionsProvider();

  late int currentQuestionIndex;
  late int selectedAnswerIndex;


  @override
  void initState() {
    super.initState();
    currentQuestionIndex = 0;
    selectedAnswerIndex = -1;
  }

  @override
  Widget build(BuildContext context) {
    final style = ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 20)
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            QuestionWidget(
                question: _getCurrentQuestion(),
                selectedAnswerIndex: selectedAnswerIndex,
                onAnswerSelectedCallback: _onAnswerSelected
            ),
            ElevatedButton(
              style: style,
              onPressed: _onCheckAnswerClicked,
              child: const Text('Check answer'),
            ),
          ],
        ),
      ),
    );
  }

  Question _getCurrentQuestion() {
    return questionsProvider.getQuestionAtIndex(currentQuestionIndex);
  }

  void _onAnswerSelected(int index) {
    setState(() {
      selectedAnswerIndex = index;
    });
  }

  void _onCheckAnswerClicked() {
    if (selectedAnswerIndex == _getCurrentQuestion().correctAnswerIndex) {
      setState(() {
        if (currentQuestionIndex < questionsProvider.getNumOfQuestions() - 1) {
          currentQuestionIndex++;
          selectedAnswerIndex = -1;
        } else {
          _showSnackBar("Quiz completed");
        }
      });
    } else {
      _showSnackBar("Incorrect");
    }
  }

  void _showSnackBar(String text) {
    final snackBar = SnackBar(duration: Duration(milliseconds: 500), content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}
