import 'package:flutter/material.dart';
import 'package:license/extension/text_extension.dart';

class PracticeSection extends StatelessWidget {
  const PracticeSection({super.key, required this.name, required this.comment});

  final String name;
  final String comment;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Text(name).w700().text18().mainColor(),
                    )
                )
              ],
            )
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Text(
            comment,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              height: 1.5
            ),
          ),
        )
      ],
    );
  }
}