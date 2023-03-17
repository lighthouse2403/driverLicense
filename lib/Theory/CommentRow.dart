import 'package:flutter/material.dart';

class CommentRow extends StatelessWidget{
  CommentRow({super.key, required this.comment});
  String comment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 16, bottom: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Colors.green.withOpacity(0.5)
        ),
        child: Text(
          comment,
          style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Colors.black,
              height: 1.3
          ),
        ),
      )
    );
  }
}

