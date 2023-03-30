import 'package:flutter/material.dart';
import 'package:license/Theory/Model/QuestionModel.dart';
import 'package:license/Theory/questionDetail.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key, required this.questionList});
  final List<QuestionModel> questionList;

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  var pageTitle = '1';
  void onPageChanged(int index) {
    setState(() {
      pageTitle = '${index + 1}';
    });
  }

  @override
  Widget build(BuildContext context) {
    print('${widget.questionList.toString()}');

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