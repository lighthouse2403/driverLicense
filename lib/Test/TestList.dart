import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:license/Database/sqlHelper.dart';
import 'package:license/Test/Model/TestModel.dart';
import 'package:flutter/services.dart';
import 'package:license/Test/TestItem.dart';
import 'package:license/Test/TestPage.dart';

class TestList extends StatefulWidget {
  const TestList({super.key});
  @override
  State<TestList> createState() => _TestListState();
}

class _TestListState extends State<TestList> {
  List<TestModel> testArray = [];

  Future<void> loadTheoryData() async {
    var finishedQuestions = await SQLHelper.getAllQuestion();
    final String testResponse = await rootBundle.loadString('assets/json/test.json');
    final testData = await json.decode(testResponse);

    // chapterArray = List<TheoryModel>.from(theoryData["chapters"].map((json) => TheoryModel.fromJson(json)));
    // for (var chapter in chapterArray) {
    //   chapter.finishedCount = finishedQuestions.where((element) => element.chapterId == chapter.id).length;
    // }
    //
    // final String questionResponse = await rootBundle.loadString('assets/json/question.json');
    // final questionData = await json.decode(questionResponse);
    // questionList = List<QuestionModel>.from(questionData["questions"].map((json) => QuestionModel.fromJson(json)));
    //
    // questionList.forEach((element) {
    //   var newElement = finishedQuestions.where((newElement) => newElement.id == element.id).first;
    //   if (newElement != null) {
    //     element.selectedIndex = newElement.selectedIndex;
    //   }
    // });
  }

  // void goToQuestionPage(int index) {
  //   var questions =  questionList.where((element) => element.chapterId == index).toList();
  //
  //   Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => QuestionPage(questionList: questions))
  //   ).then(onGoBack);
  // }



  void goToTestPage(int index) {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TestPage())
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
            return GridView.count(
              primary: false,
              padding: const EdgeInsets.all(16),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              crossAxisCount: 2,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    goToTestPage(0);
                  },
                  child: TestRow(),
                )
              ],
            );
          },
        )
    );
  }
}