import 'package:flutter/material.dart';
import 'package:license/common/app_colors.dart';
import 'package:license/extension/text_extension.dart';
import 'package:license/theory/models/chapter_model.dart';

 class TheoryRow extends StatelessWidget {
  TheoryRow({super.key, required this.theory, required this.onTap});

  final ChapterModel theory;
  Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap(theory.id);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 60,
            height: 60,
            margin:  const EdgeInsets.all(10),
            child: Stack(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  child:
                   CircularProgressIndicator(
                      value: theory.finishedCount/theory.count,
                      strokeWidth: 3,
                      backgroundColor:  Colors.grey.withOpacity(0.3),
                      valueColor: AlwaysStoppedAnimation(AppColors.mainColor)
                  ),
                ),
                Center(
                  child: Text('${theory.finishedCount}/${theory.count}').w400().text12().mainColor(),
                )
              ],
            )
          ),
          Flexible(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Text(theory.name).w500().text17().mainColor().ellipsis(),
                    ),
                    const SizedBox(height: 5,),
                    Container(
                      padding: const EdgeInsets.only(right: 2.0),
                      child: Text(
                          theory.comment,
                          style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              height: 1.3),
                          softWrap: true
                      ),
                    )
                  ],
                ),
              )
          )
        ],
      ),
    );
  }
}