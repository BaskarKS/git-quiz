import 'dart:async';

import 'package:flutter/material.dart';
import 'package:git_quiz/question.dart';
import 'package:git_quiz/quiz_results.dart';

import 'answer.dart';

class QuizResultsWidget extends StatelessWidget {

  final QuizResults quizResults;

  const QuizResultsWidget({Key? key, required this.quizResults}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Quiz completed!',
            style: TextStyle(
              color: Colors.grey[850],
              fontSize: 20,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Questions answered: ${quizResults.totalQuestions}',
            style: TextStyle(
              color: Colors.grey[850],
              fontSize: 20,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Quiz score: ${quizResults.totalPoints}/100',
            style: TextStyle(
              color: Colors.grey[850],
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

}
