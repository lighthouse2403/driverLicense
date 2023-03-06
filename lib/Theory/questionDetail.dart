import 'package:flutter/material.dart';
import 'package:license/Theory/Model/QuestionModel.dart';

class QuestionDetail extends StatefulWidget {
  const QuestionDetail({super.key, required this.question});
  final QuestionModel question;
  @override
  State<QuestionDetail> createState() => _QuestionDetailState();
}

class _QuestionDetailState extends State<QuestionDetail> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Câu hỏi số ${widget.question.id}'),
          backgroundColor: Colors.green,
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Flexible(
            child: Column(
              children: [
                Column(
                  children: [
                    Text(
                      widget.question.questionText,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black
                      ),
                    )
                  ],
                ),
                ListView.separated(
                  itemCount: widget.question.answerList.length,
                  itemBuilder: (BuildContext context, int index) {
                      return Text('Welcome');
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Container(height: 0.5, color: Colors.grey,);
                  },
                )
              ],
            ),
          ),
        )
    );
  }
}