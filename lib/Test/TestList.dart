import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:license/Test/Model/TestModel.dart';
import 'package:flutter/services.dart';
import 'package:license/Test/TestItem.dart';
import 'package:license/Test/TestPage.dart';
import 'package:license/Theory/Model/QuestionModel.dart';

import '../Database/sqlHelper.dart';

class TestList extends StatefulWidget {
  const TestList({super.key});
  @override
  State<TestList> createState() => _TestListState();
}

class _TestListState extends State<TestList> {
  List<TestModel> testArray = [];
  List<QuestionModel> finishedQuestions = [];

  Future<void> loadTheoryData() async {
    finishedQuestions = await SQLHelper.getAllQuestion('tests');
    print('finished ${finishedQuestions.length}');
    final String testResponse = await rootBundle.loadString('assets/json/tests.json');
    final testData = await json.decode(testResponse);
    testArray = List<TestModel>.from(testData["tests"].map((json) => TestModel.fromJson(json)));
    print('testArray ${testArray.length}');

    for (var test in testArray) {
      test.finishedCount = finishedQuestions.where((element) => element.testId == test.id).length;
    }
    //
    // final String questionResponse = await rootBundle.loadString('assets/json/questions.json');
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
        MaterialPageRoute(
            builder: (context) => TestPage(
                                    test: testArray[index],
                                    questionList: finishedQuestions.where((element) => element.testId == index).toList(),))
    ).then(onGoBack);
  }

  onGoBack(dynamic value) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Thi thử'),
          backgroundColor: Colors.green,
        ),
        body: FutureBuilder(
          future: loadTheoryData(),
          builder: (context, snapshot) {
            if (snapshot.hasData == null) {
              return Text('Loading');
            }
            return GridView.builder(
                itemCount: testArray.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      goToTestPage(index);
                    },
                    child: TestRow(testModel: testArray[index]),
                  );
                });
          },
        )
    );
  }
}