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
    int numberOfTruth = widget.questions.where((element) => element.selectedIndex == element.answerIndex).length;
    bool passed = (numberOfTruth >= (widget.test.licenseType?.require ?? 45));
    Color resultColor = passed ? Colors.green : Colors.red.withOpacity(0.6);

    print('Dat: $numberOfTruth');
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
                borderRadius: const BorderRadius.all(Radius.circular(6)),
                border: Border.all(
                  color: resultColor
                )
              ),
              child: Center(
                child: Text(
                  passed ? 'Đạt': 'Trươt',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: resultColor
                  ),
                ),
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