import 'package:flutter/material.dart';
import 'package:license/CustomWidget/CircularCountdownWidget.dart';
import 'package:license/Test/Model/TestModel.dart';

class TestRow extends StatelessWidget {
  TestRow({super.key, required this.testModel});

  TestModel testModel;
  // final TestModel test;
  @override
  Widget build(BuildContext context) {
    Color strokeColor = testModel.exactCount >= (testModel.questionIds.length - 2) ? Colors.green : Colors.red;
    String status = testModel.exactCount >= (testModel.questionIds.length - 2) ? 'Đạt' : 'Trượt';

    return Container(
        margin:  const EdgeInsets.all(16),
        padding: const EdgeInsets.all(4),
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: CircularCountdownWidget(percentage: testModel.exactCount/testModel.questionIds.length, strokeColor: strokeColor),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Đề số ${testModel.id + 1}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: strokeColor
                  ),
                ),
                const SizedBox(height: 6,),
                Text(
                  status,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: strokeColor,
                  ),
                ),
                const SizedBox(height: 6,),
                Text(
                  '${testModel.exactCount}/${testModel.questionIds.length}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: strokeColor
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