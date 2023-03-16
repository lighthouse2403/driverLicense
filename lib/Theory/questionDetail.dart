import 'package:flutter/material.dart';
import 'package:license/Database/sqlHelper.dart';
import 'package:license/Theory/CommentRow.dart';
import 'package:license/Theory/Model/QuestionModel.dart';
import 'package:license/Theory/SelectionRow.dart';
import 'QuestionRow.dart';

class QuestionDetail extends StatefulWidget {
  const QuestionDetail({super.key, required this.question});
  final QuestionModel question;
  @override
  State<QuestionDetail> createState() => _QuestionDetailState();
}

class _QuestionDetailState extends State<QuestionDetail> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final int answerCount = widget.question.answerList.length;

    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: ListView.separated(
        itemCount: answerCount > 0 ? answerCount + 2 : 0,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return QuestionRow(question: widget.question.questionText);
          } else if (index == answerCount + 1)  {
            return CommentRow(comment: widget.question.comment);
          } else {
            return InkWell(
              onTap: () {
                SQLHelper().insertQuestion(widget.question);
                setState(() {
                  selectedIndex = index - 1;
                });
              },
              child: SelectionRow(question: widget.question, index: index - 1, selectedIndex: selectedIndex),
            );
          }
        },
        separatorBuilder: (BuildContext context, int index) {
          return Container(height: 0.5, color: Colors.grey.withOpacity(0.6),);
        },
      ),
    );
  }
}