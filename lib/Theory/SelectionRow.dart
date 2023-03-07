import 'package:flutter/material.dart';
import 'package:license/Theory/Model/QuestionModel.dart';

class SelectionRow extends StatefulWidget {
  SelectionRow({super.key, required this.question, required this.index, required this.selectedIndex});

  QuestionModel question;
  int index = 0;
  int selectedIndex = -1;

  @override
  State<SelectionRow> createState() => SelectionRowState();
}

class SelectionRowState extends State<SelectionRow> {

  @override
  Widget build(BuildContext context) {
    Color answerTextColor = Colors.black;
    bool isCorrect = widget.question.answerIndex == widget.selectedIndex;
    answerTextColor = (widget.index == widget.selectedIndex) && isCorrect ? Colors.green : answerTextColor;
    answerTextColor = (widget.index == widget.selectedIndex) && !isCorrect ? Colors.red : answerTextColor;

    return Container(
      padding: const EdgeInsets.only(left: 10, right: 5, top: 12, bottom: 12),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: widget.index == widget.selectedIndex ? Colors.green : Colors.grey,
                  width: 2,
                )
            ),
          ),
          const SizedBox(width: 10,),
          Flexible(
              child: Text(
                widget.question.answerList[widget.index],
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: answerTextColor,
                ),
              )
          )
        ],
      ),
    );
  }
}