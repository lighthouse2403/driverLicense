import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:license/Database/sqlHelper.dart';
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
  List<TheoryModel> chapterArray = [];
  List<QuestionModel> questionList = [];

  Future<void> loadTheoryData() async {
    var finishedQuestions = await SQLHelper.getAllQuestion('questions');
    final String theoryResponse = await rootBundle.loadString('assets/json/theory.json');
    final theoryData = await json.decode(theoryResponse);

    chapterArray = List<TheoryModel>.from(theoryData["chapters"].map((json) => TheoryModel.fromJson(json)));
    for (var chapter in chapterArray) {
      chapter.finishedCount = finishedQuestions.where((element) => element.chapterId == chapter.id).length;
    }

    final String questionResponse = await rootBundle.loadString('assets/json/questions.json');
    final questionData = await json.decode(questionResponse);
    questionList = List<QuestionModel>.from(questionData["questions"].map((json) => QuestionModel.fromJson(json, null)));

    questionList.forEach((element) {
        var newElement = finishedQuestions.where((newElement) => newElement.id == element.id).first;
        if (newElement != null) {
          element.selectedIndex = newElement.selectedIndex;
        }
    });
  }

  void goToQuestionPage(int index) {
    var questions =  questionList.where((element) => element.chapterId == index).toList();

    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => QuestionPage(questionList: questions))
    ).then(onGoBack);
  }

  onGoBack(dynamic value) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lý thuyết'),
        backgroundColor: Colors.green,
      ),
      body: FutureBuilder(
        future: loadTheoryData(),
        builder: (context, snapshot) {
          return ListView.separated(
            itemCount: chapterArray.length,
            itemBuilder: (BuildContext context, int index) {
              var row = TheoryRow(theory: chapterArray[index], onTap: goToQuestionPage);
              return row;
            },
            separatorBuilder: (BuildContext context, int index) {
              return Container(height: 0.5, color: Colors.grey,);
            },
          );
        },
      )
    );
  }
}