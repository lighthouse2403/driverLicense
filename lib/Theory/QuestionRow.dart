import 'package:flutter/material.dart';
import 'package:license/Theory/Model/QuestionModel.dart';

// ignore: must_be_immutable
class QuestionRow extends StatelessWidget{
  QuestionRow({super.key, required this.question});

  QuestionModel question;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question.questionText,
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 17,
                color: Colors.black
            ),
          ),
          const SizedBox(height: 10,),
          question.questionImage.isEmpty ? Container(height: 0): Image.asset('assets/icon/question/${question.questionImage}.png'),
        ],
      )
    );
  }
}

