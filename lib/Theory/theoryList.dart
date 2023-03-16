import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:license/Theory/Model/QuestionModel.dart';
import 'package:license/Theory/Model/TheoryModel.dart';
import 'package:license/Theory/questionPage.dart';
import 'package:license/Theory/theoryRow.dart';
import 'package:flutter/services.dart';

class TheoryList extends StatefulWidget {
  const TheoryList({super.key});
  @override
  State<TheoryList> createState() => _TheoryListState();
}

class _TheoryListState extends State<TheoryList> {
  List chapterArray = [];
  List<QuestionModel> questionList = [];

  Future<void> loadTheoryData() async {
    final String response = await rootBundle.loadString('assets/json/theory.json');
    final data = await json.decode(response);
    print(data.toString());
    setState(() {
      chapterArray = data["chapers"];
    });
  }

  Future<void> loadQuestionData() async {
    final String response = await rootBundle.loadString('assets/json/question.json');
    final data = await json.decode(response);
    questionList = List<QuestionModel>.from(data["questions"].map((json) => QuestionModel.fromJson(json)));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadTheoryData();
    loadQuestionData();
  }

  void goToQuestionPage(int index) {
    print('goToQuestionPage: ' + index.toString());

    var questions =  questionList.where((element) => element.chapterId == index).toList();
    print('question:' + questions.toString());
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => QuestionPage(questionList: questions)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lý thuyết'),
        backgroundColor: Colors.green,
      ),
      body: ListView.separated(
        itemCount: chapterArray.length,
        itemBuilder: (BuildContext context, int index) {
          var theoryModel = TheoryModel.fromJson(chapterArray[index]);
          var row = TheoryRow(theory: theoryModel, onTap: goToQuestionPage);
          return row;
        },
        separatorBuilder: (BuildContext context, int index) {
          return Container(height: 0.5, color: Colors.grey,);
        },
      ),
    );
  }
}