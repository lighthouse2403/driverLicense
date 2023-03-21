import 'package:flutter/material.dart';
import 'package:license/CustomWidget/CircularCountdownWidget.dart';
import 'package:license/Test/Model/TestModel.dart';

class TestRow extends StatelessWidget {
  TestRow({super.key, required this.testModel});

  TestModel testModel;
  // final TestModel test;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin:  const EdgeInsets.all(10),
        padding: const EdgeInsets.all(8),
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: CircularCountdownWidget(percentage: testModel.finishedCount/testModel.questionIds.length),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Đề số ${testModel.id + 1}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.green
                  ),
                ),
                const SizedBox(height: 3,),
                Text(
                  '${testModel.finishedCount}/${testModel.questionIds.length}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black
                  ),
                ),
              ],
            )

            )
          ],
        )
    );
  }
}