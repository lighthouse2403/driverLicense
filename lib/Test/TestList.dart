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

    testArray = List<TestModel>.from(testData["test"].map((json) => TestModel.fromJson(json)));
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
          title: const Text('Thi thử'),
          backgroundColor: Colors.green,
        ),
        body: FutureBuilder(
          future: loadTheoryData(),
          builder: (context, snapshot) {
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