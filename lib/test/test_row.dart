import 'package:flutter/material.dart';
import 'package:license/customer_widget/circular_countdown.dart';
import 'package:license/test/model/test_model.dart';

class TestRow extends StatelessWidget {
  TestRow({super.key, required this.testModel});

  TestModel testModel;
  // final TestModel test;
  @override
  Widget build(BuildContext context) {
    Color strokeColor = Colors.grey;
    String status = 'LÀM BÀI';

    if (testModel.status == 1) {
      status = testModel.exactCount >= (testModel.licenseType?.require ?? testModel.questionIds.length - 2) ? 'ĐẠT' : 'TRƯỢT';
      strokeColor = testModel.exactCount < (testModel.licenseType?.require ?? 45) ? Colors.red : strokeColor;
    }

    return Container(
        margin:  const EdgeInsets.all(2),
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
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: strokeColor
                  ),
                ),
                const SizedBox(height: 6,),
                Text(
                  status,
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: strokeColor,
                  ),
                ),
                const SizedBox(height: 6),
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