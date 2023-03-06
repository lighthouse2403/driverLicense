import 'package:flutter/material.dart';
import 'package:license/Theory/Model/QuestionModel.dart';

class QuestionDetail extends StatefulWidget {
  const QuestionDetail({super.key, required this.question});
  final QuestionModel question;
  @override
  State<QuestionDetail> createState() => _QuestionDetailState();
}

class _QuestionDetailState extends State<QuestionDetail> {

  @override
  Widget build(BuildContext context) {
    return Text(widget.question.comment);
  }
}