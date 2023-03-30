import 'package:flutter/material.dart';
import 'package:license/Test/Model/TestModel.dart';
import 'package:license/Theory/Model/QuestionModel.dart';
import 'TestResultRow.dart';

class TestResult extends StatefulWidget {
  TestResult({super.key, required this.questions, required this.test});

  @override
  State<TestResult> createState() => _TestResultState();
  List<QuestionModel> questions = [];
  TestModel test;
}

class _TestResultState extends State<TestResult> {

  onGoBack(dynamic value) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Đề số ${widget.test.id + 1}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600
            ),
          ),
          backgroundColor: Colors.green,
        ),
        body: Column(
          children: [
            Container(
              height: 50,
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                border: Border.all(
                  color: Colors.green
                )
              ),
              child: Center(
                child: Text('Trươt'),
              )
            ),
            Expanded(
                child: Container(
                  margin: const EdgeInsets.only(right: 16, left: 16),
                  child: GridView.builder(
                      itemCount: widget.questions.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                          },
                          child: TestResultRow(question: widget.questions[index], index: index,),
                        );
                      }
                  )
                )
            )
          ],
        )
    );
  }
}