import 'package:flutter/material.dart';
import 'package:license/Theory/TheoryModel.dart';
import 'package:license/Theory/theoryDetail.dart';

class TheoryRow extends StatelessWidget {
  const TheoryRow({super.key, required this.theory});

  final TheoryModel theory;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TheoryDetail(type: 0,)));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
            child: Image.asset('assets/home/tips.png', width: 50, height: 50,),
          ),
          Flexible(
              child: Container(
                padding: EdgeInsets.all(10),
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
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Text(
                          theory.comment,
                          style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
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