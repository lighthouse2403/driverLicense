import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:license/common/base/base_app_bar.dart';
import 'package:license/test/model/test_model.dart';
import 'package:license/theory/models/theory_question_model.dart';
import 'test_result_row.dart';

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
    Color resultColor = passed ? Colors.green : Colors.red;
    String resultString = passed ? 'Đạt': 'Không đạt';

    return Scaffold(
        appBar: BaseAppBar(title: 'Đề số ${widget.test.id + 1}'),
        body: Column(
          children: [
            Container(
              height: 50,
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: resultColor.withOpacity(0.2),
                borderRadius: const BorderRadius.all(Radius.circular(6)),
                border: Border.all(
                  color: resultColor
                )
              ),
              child: Container(
                margin: const EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    '$resultString: $numberOfTruth/${widget.test.total} ',
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
                        color: Colors.red
                    ),
                  )
                )
              )
            ),
            Expanded(
                child: Container(
                  margin: const EdgeInsets.only(right: 16, left: 16),
                  child: GridView.builder(
                      itemCount: widget.questions.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pop(context, index);
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