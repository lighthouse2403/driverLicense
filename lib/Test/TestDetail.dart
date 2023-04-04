import 'package:flutter/material.dart';
import 'package:license/Database/sqlHelper.dart';
import 'package:license/Test/QuestionInTestRow.dart';
import 'package:license/Test/TestPage.dart';
import 'package:license/Theory/CommentRow.dart';
import 'package:license/Theory/Model/QuestionModel.dart';
import '../Theory/QuestionRow.dart';
import 'Model/TestModel.dart';

class TestDetail extends StatefulWidget {
  TestDetail({super.key, required this.question, required this.test, required this.testStatus, required this.updateQuestion});
  QuestionModel question;
  TestModel test;
  TestStatus testStatus;
  Function(QuestionModel) updateQuestion;

  @override
  State<TestDetail> createState() => _TestDetailState();
}

class _TestDetailState extends State<TestDetail> {

  @override
  Widget build(BuildContext context) {
    final int answerCount = widget.question.answerList.length;
    return FutureBuilder(
        future: SQLHelper().getQuestionOnTest(widget.question.questionOnTestId),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            widget.question = snapshot.data!;
          }
          return Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: ListView.separated(
              itemCount: ((widget.question.selectedIndex != -1) && (widget.testStatus == TestStatus.done) && widget.question.comment.isNotEmpty) ? answerCount + 2 : answerCount + 1,
              itemBuilder: (BuildContext context, int index) {

                if (index == 0) {
                  return QuestionRow(question: widget.question);
                } else if (index == answerCount + 1) {
                  if ((widget.question.selectedIndex != -1) && (widget.question.testId == widget.test.id) && widget.testStatus == TestStatus.done) {
                    return CommentRow(comment: widget.question.comment);
                  }
                  return Container();
                } else {
                  return InkWell(
                    onTap: () {
                      if (widget.testStatus != TestStatus.testing) {
                        return;
                      }
                      bool isShouldUpdate = (widget.question.selectedIndex != -1);
                      widget.question.selectedIndex = index - 1;
                      widget.question.testId = widget.test.id;
                      widget.question.questionOnTestId = '${widget.test.id}-${widget.question.id}';
                      widget.updateQuestion(widget.question);
                      const tableName = 'questions_in_test';
                      isShouldUpdate ? SQLHelper().updateQuestionOnTest(widget.question, tableName) : SQLHelper().insertQuestion(widget.question, tableName);
                      setState(() {
                      });
                    },
                    child: QuestionInTestRow(question: widget.question, index: index - 1, testStatus: widget.testStatus,),
                  );
                }
              },
              separatorBuilder: (BuildContext context, int index) {
                return Container(height: 0.5, color: Colors.grey.withOpacity(0.6),);
              },
            ),
          );
        }
    );
  }
}