import 'package:flutter/material.dart';

class TimeWidget extends StatelessWidget {
  TimeWidget({super.key, required this.minutes, required this.seconds});

  String minutes = '';
  String seconds = '';

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        const Center(
          child: Text(
            ':',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 20),
          ),
        ),
        Center(
          child: Container(
            padding: const EdgeInsets.only(right: 38, top: 2),
            child: Text(
              minutes,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 20),
            ),
          ),
        ),
        Center(
          child: Container(
            padding: const EdgeInsets.only(left: 38, top: 2),
            child: Text(
              seconds,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 20),
            ),
          ),
        )
      ],
    );
  }
}

