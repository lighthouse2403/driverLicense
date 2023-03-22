import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:license/Test/Model/TestModel.dart';
import '../Theory/Model/QuestionModel.dart';
import 'TestDetail.dart';

class TestPage extends StatefulWidget {
  TestPage({super.key, required this.test, required this.finishedQuestionList});
  // final TestModel test;
  TestModel test;
  List<QuestionModel> finishedQuestionList = [];

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  var pageTitle = '1';
  List<QuestionModel> questionList = [];

  void onPageChanged(int index) {
    setState(() {
      pageTitle = '${index + 1}';
    });
  }

  Future<void> getQuestionList() async {
    final String questionResponse = await rootBundle.loadString('assets/json/questions.json');
    final questionData = await json.decode(questionResponse);
    questionList = List<QuestionModel>.from(questionData["questions"].map((json) => QuestionModel.fromJson(json, null))).where((element) => widget.test.questionIds.contains(element.id)).toList();
    print("finished question is: ${widget.finishedQuestionList.length}");

    for (var question in questionList) {
      if (widget.finishedQuestionList.where((element) => (element.id == question.id) && element.testId == widget.test.id ).isNotEmpty) {
          question = widget.finishedQuestionList.where((element) => element.id == question.id).first;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Column(
                  children: [
                    Text(
                      'Đề ${widget.test.id + 1}',
                      style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      'Câu hỏi số $pageTitle',
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    )
                  ],
          ) ,
          backgroundColor: Colors.green,
        ),
        body: FutureBuilder(
          future: getQuestionList(),
          builder: (context, snapshot) {
            return Container(
              color: Colors.white,
              child: PageView.builder(
                itemCount: widget.test.questionIds.length,
                scrollDirection: Axis.horizontal,
                onPageChanged: onPageChanged,
                itemBuilder: (BuildContext context, int index) {
                  return TestDetail(question: questionList[index], test: widget.test,);
                },
              ),
            );
          },
        )
    );
  }
}