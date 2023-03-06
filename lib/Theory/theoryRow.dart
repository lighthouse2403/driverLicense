import 'package:flutter/material.dart';
import 'package:license/Theory/Model/TheoryModel.dart';
import 'package:license/Theory/questionPage.dart';

class TheoryRow extends StatelessWidget {
  const TheoryRow({super.key, required this.theory});

  final TheoryModel theory;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const QuestionPage()));
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
                  const CircularProgressIndicator(
                      value: 0.5,
                      strokeWidth: 3,
                      backgroundColor:  Colors.blueGrey,
                      valueColor: AlwaysStoppedAnimation(Colors.green)
                  ),
                ),
                const Center(
                  child: Text(
                      '30/182',
                      style: TextStyle(
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