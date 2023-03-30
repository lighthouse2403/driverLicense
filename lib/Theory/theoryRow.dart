import 'package:flutter/material.dart';
import 'package:license/Theory/Model/ChapterModel.dart';

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
                      valueColor: const AlwaysStoppedAnimation(Colors.green)
                  ),
                ),
                Center(
                  child: Text(
                      '${theory.finishedCount}/${theory.count}',
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.green
                      ),
                  ),
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
                      child: Text(
                          theory.name,
                          style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w500, fontSize: 18),
                          softWrap: true
                      ),
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