import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:license/Theory/Model/QuestionModel.dart';
import 'package:license/Theory/questionDetail.dart';

class QuestionPage extends StatefulWidget {
  QuestionPage({super.key, required this.questionList});
  @override
  State<QuestionPage> createState() => _QuestionPageState();

  List<QuestionModel> questionList = [];
}

class _QuestionPageState extends State<QuestionPage> {

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: 10,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return QuestionDetail(question: widget.questionList[index]);
      },
    );
  }
}