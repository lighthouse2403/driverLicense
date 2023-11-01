import 'package:flutter/material.dart';
import 'package:license/common/app_colors.dart';

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
            color: AppColors.mainColor.withOpacity(0.5)
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Icon(
                  Icons.question_answer,
                  color: Colors.black,
                  size: 24.0,
                ),
                SizedBox(width: 5,),
                Center(
                  child: Text(
                      'Giải thích đáp án:',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Colors.black,
                          height: 1.3
                      )
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Text(
              comment,
              style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Colors.black,
                  height: 1.3
              ),
            )
          ],
        )

      )
    );
  }
}

