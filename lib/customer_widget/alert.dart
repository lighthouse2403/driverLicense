
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Alert extends StatelessWidget {
  Alert({required this.confirmPressed});

  final VoidCallback confirmPressed;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CupertinoAlertDialog (
      title: const Text('Xác nhận'),
      content: const Text('Bạn có muốn xoá tất cả lịch sử ôn tập không?'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Huỷ',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.red
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            confirmPressed();
            Navigator.pop(context);
          },
          child: const Text(
            'Xoá',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Colors.black
            ),
          ),
        )
      ],
    );
  }
}