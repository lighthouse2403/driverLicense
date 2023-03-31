import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:license/Setting/Model/LicenseTypeModel.dart';
import 'package:license/Test/Model/TestModel.dart';
import 'package:flutter/services.dart';
import 'package:license/Test/TestRow.dart';
import 'package:license/Test/TestPage.dart';
import 'package:license/Theory/Model/QuestionModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    finishedQuestions = await SQLHelper.getAllQuestion('questions_in_test');
    final String testResponse = await rootBundle.loadString('assets/json/tests.json');
    final testData = await json.decode(testResponse);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int licenseId = prefs.getInt('licenseType') ?? 2;
    testArray = List<TestModel>.from(testData['$licenseId'].map((json) => TestModel.fromJson(json)));

    final String licenseTypeString = await rootBundle.loadString('assets/json/licenseTypes.json');
    final licenseTypeData = await json.decode(licenseTypeString);
    List<LicenseTypeModel> licenses = List<LicenseTypeModel>.from(licenseTypeData['licenseTypes'].map((json) => LicenseTypeModel.fromJson(json)));

    for (var test in testArray) {
      test.finishedCount = finishedQuestions.where((element) => element.testId == test.id).length;
      test.exactCount = finishedQuestions.where((element) => (element.testId == test.id) && (element.selectedIndex == element.answerIndex)).length;
      test.licenseType = licenses.where((element) => element.id == licenseId).first;
    }
  }

  void goToTestPage(int index) {
    var finishedQuestion = finishedQuestions.where((element) => element.testId == index) ?? [];
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TestPage(
                                    test: testArray[index],
                                    finishedQuestionList: finishedQuestion.toList(),))
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