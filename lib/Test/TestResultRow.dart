import 'package:flutter/material.dart';

import '../Theory/Model/QuestionModel.dart';

class TestResultRow extends StatelessWidget {
  TestResultRow({super.key, required this.question, required this.index});

  QuestionModel question;
  int index;

  @override
  Widget build(BuildContext context) {
    Color questionColor = question.selectedIndex == question.answerIndex ? Colors.green : Colors.grey.withOpacity(0.6);
    questionColor = question.isDeadPoint ? Colors.red.withOpacity(0.6) : questionColor;
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          color: questionColor
        ),
        child: Center (
          child: Text(
            '${index + 1}',
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600
            ),
          ),
        )
    );
  }
}