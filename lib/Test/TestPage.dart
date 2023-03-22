import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:license/Test/Model/TestModel.dart';
import '../Theory/Model/QuestionModel.dart';
import 'TestDetail.dart';

class TestPage extends StatefulWidget {
  TestPage({super.key, required this.test, required this.questionList});
  // final TestModel test;
  TestModel test;
  List<QuestionModel> questionList = [];

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
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
        body: Container(
          color: Colors.white,
          child: PageView.builder(
            itemCount: widget.test.questionIds.length,
            scrollDirection: Axis.horizontal,
            onPageChanged: onPageChanged,
            itemBuilder: (BuildContext context, int index) {
              return TestDetail(question: widget.questionList[index]);
            },
          ),
        ),
    );
  }
}