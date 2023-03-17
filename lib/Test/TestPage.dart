import 'package:flutter/material.dart';
import 'package:license/Test/Model/TestModel.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});
  // final TestModel test;

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  var pageTitle = '1';
  void onPageChanged(int index) {
    setState(() {
      pageTitle = '${index + 1}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Câu hỏi số $pageTitle'),
          backgroundColor: Colors.green,
        ),
        body: Container(
          color: Colors.white,
          child: PageView.builder(
            itemCount: 10,
            scrollDirection: Axis.horizontal,
            onPageChanged: onPageChanged,
            itemBuilder: (BuildContext context, int index) {
              return Container();
            },
          ),
        )
    );
  }
}