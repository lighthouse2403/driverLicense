import 'package:flutter/material.dart';
import 'package:license/Database/sqlHelper.dart';
import 'package:license/Theory/CommentRow.dart';
import 'package:license/Theory/Model/QuestionModel.dart';
import 'package:license/Theory/AnswerRow.dart';
import 'QuestionRow.dart';

class QuestionDetail extends StatefulWidget {
  QuestionDetail({super.key, required this.question});
  QuestionModel question;
  @override
  State<QuestionDetail> createState() => _QuestionDetailState();
}

class _QuestionDetailState extends State<QuestionDetail> {

  @override
  Widget build(BuildContext context) {
    final int answerCount = widget.question.answerList.length;

    return FutureBuilder(
        future: SQLHelper.getQuestion(widget.question.id, 'questions'),
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
                } else if ((index == answerCount + 1) && (widget.question.selectedIndex != -1)) {
                  return CommentRow(comment: widget.question.comment);
                } else {
                  return InkWell(
                    onTap: () {
                      bool isShouldUpdate = widget.question.selectedIndex != -1;
                      widget.question.selectedIndex = index - 1;
                      const tableName = 'questions';
                      SQLHelper().insertQuestion(widget.question, tableName);
                      setState(() {
                      });
                    },
                    child: AnswerRow(question: widget.question, index: index - 1,),
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