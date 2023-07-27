import 'package:flutter/material.dart';
import 'package:license/database/sql_helper.dart';
import 'package:license/theory/answer_row.dart';
import 'package:license/theory/comment_row.dart';
import 'package:license/theory/models/theory_question_model.dart';
import 'question_row.dart';

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
          if (snapshot.hasData) {
            widget.question = snapshot.data!;
          }
          return Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: ListView.separated(
              itemCount: ((widget.question.selectedIndex != -1) && widget.question.comment.isNotEmpty) ? answerCount + 2 : answerCount + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return QuestionRow(question: widget.question);
                } else if (index == answerCount + 1) {
                  return (widget.question.selectedIndex != -1) ? CommentRow(comment: widget.question.comment) : Container();
                } else {
                  return InkWell(
                    onTap: () {
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