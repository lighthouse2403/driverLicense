import 'package:flutter/material.dart';

// ignore: must_be_immutable
class QuestionRow extends StatelessWidget{
  QuestionRow({super.key, required this.question});

  String question;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 5, top: 10, bottom: 20),
      child: Text(
        question,
        style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.black
        ),
      ),
    );
  }
}

