import 'package:flutter/material.dart';
import 'package:license/Theory/Model/QuestionModel.dart';
import '../Database/sqlHelper.dart';

class AnswerRow extends StatelessWidget {
  AnswerRow({super.key, required this.question, required this.index});

  QuestionModel question;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    Color answerTextColor = Colors.black;
    Color backgroundColor = Colors.white;
    Color textColor = Colors.black;
    bool isCorrect = question.answerIndex == question.selectedIndex;

    print('Answer row: selectedId: ${question.selectedIndex}');
    int numberOfAnswer = index + 1;

    if (index == question.selectedIndex)  {
      answerTextColor = isCorrect ? Colors.green : Colors.red;
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
                    color: textColor
                ),
              ),
            ),
          ),
          const SizedBox(width: 10,),
          Flexible(
              child: Text(
                question.answerList[index],
                style: TextStyle(
                  fontSize: 14,
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

