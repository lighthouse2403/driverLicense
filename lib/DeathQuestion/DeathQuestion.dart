import 'package:flutter/material.dart';
import 'package:license/Theory/Model/QuestionModel.dart';
import 'package:license/Theory/questionDetail.dart';

class DeathQuestionPage extends StatefulWidget {
  const DeathQuestionPage({super.key, required this.questionList});
  final List<QuestionModel> questionList;

  @override
  State<DeathQuestionPage> createState() => _DeathQuestionPageState();
}

class _DeathQuestionPageState extends State<DeathQuestionPage> {
  var pageTitle = '1';
  void onPageChanged(int index) {
    setState(() {
      pageTitle = '${index + 1}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Câu hỏi số $pageTitle'),
          backgroundColor: Colors.green,
        ),
        body: Container(
          color: Colors.white,
          child: PageView.builder(
            itemCount: widget.questionList.length,
            scrollDirection: Axis.horizontal,
            onPageChanged: onPageChanged,
            itemBuilder: (BuildContext context, int index) {
              return QuestionDetail(question: widget.questionList[index]);
            },
          ),
        )
    );
  }
}