import 'package:flutter/material.dart';
import 'package:license/test_list/test_page.dart';
import 'package:license/theory/models/theory_question_model.dart';

class QuestionInTestRow extends StatelessWidget {
  QuestionInTestRow({super.key, required this.question, required this.index, required this.testStatus});

  QuestionModel question;
  int index = 0;
  TestStatus testStatus;

  @override
  Widget build(BuildContext context) {
    Color answerTextColor = Colors.black;
    Color backgroundColor = Colors.white;
    Color textColor = Colors.black;
    bool isCorrect = question.answerIndex == question.selectedIndex;
    bool isSelected = index == question.selectedIndex;
    int numberOfAnswer = index + 1;
    bool isTesting = testStatus == TestStatus.testing;

    if (isSelected) {
      answerTextColor = isCorrect ? Colors.green : Colors.red;
      answerTextColor = isTesting ? Colors.orangeAccent: answerTextColor;
      backgroundColor = answerTextColor;
      textColor = Colors.white;
    }

    return Container(
      padding: const EdgeInsets.only(left: 10, right: 5, top: 12, bottom: 12),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: answerTextColor.withOpacity(0.5),
                width: 1,
              ),
              color: backgroundColor,
            ),
            child: Center(
              child: Text(
                '$numberOfAnswer',
                style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10,),
          Flexible(
              child: Text(
                question.answerList[index],
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: answerTextColor,
                ),
              )
          )
        ],
      ),
    );
  }
}

