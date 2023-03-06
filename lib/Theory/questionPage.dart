import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:license/Theory/Model/QuestionModel.dart';
import 'package:license/Theory/questionDetail.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});
  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  List questionList = [];

  Future<void> loadQuestionData() async {
    final String response = await rootBundle.loadString('assets/json/question.json');
    final data = await json.decode(response);
    setState(() {
      questionList = data["questions"];
    });
    print(data.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadQuestionData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Biển báo'),
        backgroundColor: Colors.green,
      ),
      body: PageView.builder(
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return QuestionDetail(question: QuestionModel.fromJson(questionList[index]));
        },
      ),
    );
  }
}