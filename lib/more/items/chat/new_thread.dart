import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:license/more/model/thread_model.dart';

class NewThread extends StatefulWidget {
  const NewThread({super.key});
  @override
  State<NewThread> createState() => _NewThreadState();
}

class _NewThreadState extends State<NewThread> {
  ThreadModel? threads;

  onGoBack(dynamic value) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Thêm chủ đề',
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: Colors.white
            ),
          ),
          backgroundColor: Colors.green,
        ),
        body: Container()
    );
  }
}