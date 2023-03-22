import 'package:flutter/material.dart';
import 'package:license/Database/sqlHelper.dart';
import 'package:license/Test/QuestionInTestRow.dart';
import 'package:license/Theory/CommentRow.dart';
import 'package:license/Theory/Model/QuestionModel.dart';
import '../Theory/QuestionRow.dart';
import 'Model/TestModel.dart';

class TestDetail extends StatefulWidget {
  TestDetail({super.key, required this.question, required this.test});
  QuestionModel question;
  TestModel test;

  @override
  State<TestDetail> createState() => _TestDetailState();
}

class _TestDetailState extends State<TestDetail> {

  @override
  Widget build(BuildContext context) {
    final int answerCount = widget.question.answerList.length;
    return FutureBuilder(
        future: SQLHelper.getQuestionOnTest(widget.test.id, widget.question.id),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            widget.question = snapshot.data!;
          }
          return Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: ListView.separated(
              itemCount: (widget.question.selectedIndex != -1) ? answerCount + 2 : answerCount + 1,
              itemBuilder: (BuildContext context, int index) {

                if (index == 0) {
                  return QuestionRow(question: widget.question.questionText);
                } else if (index == answerCount + 1) {
                  if ((widget.question.selectedIndex != -1) && (widget.question.testId == widget.test.id)) {
                    return CommentRow(comment: widget.question.comment);
                  }
                  return Container();
                } else {
                  return InkWell(
                    onTap: () {
                      bool isShouldUpdate = (widget.question.selectedIndex != -1);
                      widget.question.selectedIndex = index - 1;
                      widget.question.testId = widget.test.id;
                      widget.question.questionOnTestId = '${widget.test.id}-${widget.question.id}';

                      const tableName = 'tests';
                      isShouldUpdate ? SQLHelper().updateQuestion(widget.question, tableName) : SQLHelper().insertQuestion(widget.question, tableName);
                      setState(() {
                      });
                    },
                    child: QuestionInTestRow(question: widget.question, index: index - 1),
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