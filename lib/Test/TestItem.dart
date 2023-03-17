import 'package:flutter/material.dart';
import 'package:license/CustomWidget/Progress.dart';

class TestRow extends StatelessWidget {
  TestRow({super.key});

  // final TestModel test;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin:  const EdgeInsets.all(10),
        padding:  const EdgeInsets.all(6),
        child: Stack(
          children: [
            Positioned.fill(
              child: CircularCountdownWidget(),
            ),
            Center(
              child: Text(
                'Mới',
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.green
                ),
              ),
            )
          ],
        )
    );
  }
}