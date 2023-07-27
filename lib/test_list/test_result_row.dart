import 'package:flutter/material.dart';
import 'package:license/theory/models/theory_question_model.dart';

class TestResultRow extends StatelessWidget {
  TestResultRow({super.key, required this.question, required this.index});

  QuestionModel question;
  int index;

  @override
  Widget build(BuildContext context) {
    Color questionColor = question.isDeadPoint ? Colors.red.withOpacity(0.8) : Colors.grey.withOpacity(0.8);
    questionColor = question.selectedIndex == question.answerIndex ? Colors.green : questionColor;
    return Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          color: questionColor
        ),
        child: Center (
          child: Text(
            '${index + 1}',
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color:  Colors.white
            ),
          ),
        )
    );
  }
}