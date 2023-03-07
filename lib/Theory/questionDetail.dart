import 'package:flutter/material.dart';
import 'package:license/Theory/Model/QuestionModel.dart';
import 'package:license/Theory/SelectionRow.dart';

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
    return Scaffold(
        appBar: AppBar(
          title: Text('Câu hỏi số ${widget.question.id}'),
          backgroundColor: Colors.green,
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: ListView.separated(
            itemCount: widget.question.answerList.length,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Container(
                  padding: const EdgeInsets.only(left: 5, right: 2, top: 10, bottom: 20),
                  child: Text(
                    widget.question.questionText,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.black
                    ),
                  ),
                );
              }
              return InkWell(
                onTap: () {
                  setState(() {
                    selectedIndex = index - 1;
                  });
                },
                child: SelectionRow(question: widget.question, index: index - 1, selectedIndex: selectedIndex),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Container(height: 0.5, color: Colors.greenAccent,);
            },
          ),
        )
    );
  }
}