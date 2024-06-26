import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:license/ads/ads_helper.dart';
import 'package:license/common/app_colors.dart';
import 'package:license/common/constant.dart';
import 'package:license/database/sql_helper.dart';
import 'package:license/extension/text_extension.dart';
import 'package:license/setting/model/license_model.dart';
import 'package:license/test/model/test_model.dart';
import 'package:license/test/test_page.dart';
import 'package:license/test/test_row.dart';
import 'package:license/theory/models/theory_question_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestList extends StatefulWidget {
  const TestList({super.key});
  @override
  State<TestList> createState() => _TestListState();
}

class _TestListState extends State<TestList> {
  List<TestModel> testArray = [];
  List<QuestionModel> finishedQuestions = [];
  List<QuestionModel> questionList = [];
  final random = Random();
  List<LicenseTypeModel> licenseTypes = [];

  List<QuestionModel> getRandomTests(List<QuestionModel> parentQuestions, int count) {
    List<QuestionModel> randomQuestion = List.generate(count, (_) => parentQuestions[random.nextInt(parentQuestions.length)]);
    return randomQuestion;
  }

  void generateRandomTest() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int currentLicenseTypeId = prefs.getInt('licenseType') ?? 2;
    List<int> architectureArray = architecture[currentLicenseTypeId - 1];

    List<QuestionModel> randomQuestion = [];
    List<QuestionModel> deathQuestions = questionList.where((element) => element.isDeadPoint).toList();

    randomQuestion.addAll(getRandomTests(deathQuestions,1));
    // Get defineQuestion
    for (var i = 0; i < 7; i++) {
      List<QuestionModel> question = questionList.where((element) => (element.chapterId == (i + 1)) && !element.isDeadPoint).toList();
      List<QuestionModel> selectedQuestion = getRandomTests(question,architectureArray[i]);
      randomQuestion.addAll(selectedQuestion);
    }

    int newRandomId = testArray.length;
    LicenseTypeModel? currentLicenseType = licenseTypes.where((element) => element.id == currentLicenseTypeId).firstOrNull;

    TestModel newRandomTest = TestModel(
        id: newRandomId,
        status: 0,
        finishedCount: 0,
        total: 35,
        hasDeadthPoint: true,
        licenseType: currentLicenseType
    );

    newRandomTest.questionIds = randomQuestion.map((e) => '${e.id}').toList();

    await SQLHelper().insertTest(newRandomTest, 'random_tests');

    testArray.add(newRandomTest);
    setState(() {
    });
    goToTestPage(testArray.length - 1);
  }

  Future<void> loadTheoryData() async {
    // Detect license type like B1, B2, C,D, E, F
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int licenseId = prefs.getInt('licenseType') ?? 2;

    // Get finished question to show it in finished test
    finishedQuestions = await SQLHelper.getAllQuestion('questions_in_test');
    List<TestModel> finishedTest = await SQLHelper().getAllTest(licenseId);

    // Get random test by license type
    List<TestModel> randomTests = await SQLHelper().getAllRandomTest(licenseId);

    final String testResponse = await rootBundle.loadString('assets/json/tests.json');
    final testData = await json.decode(testResponse);
    testArray = List<TestModel>.from(testData['$licenseId'].map((json) => TestModel.fromJson(json)));
    testArray.addAll(randomTests);

    // Get all license type to import to test
    final String licenseResponse = await rootBundle.loadString('assets/json/licenseTypes.json');
    final licenseData = await json.decode(licenseResponse);
    licenseTypes = List<LicenseTypeModel>.from(licenseData["licenseTypes"].map((json) => LicenseTypeModel.fromJson(json)));

    // Get all question to show in test and make random test
    final String questionResponse = await rootBundle.loadString('assets/json/questions.json');
    final questionData = await json.decode(questionResponse);
    questionList = List<QuestionModel>.from(questionData["questions"].map((json) => QuestionModel.fromJson(json, null)));

    // Update question information in the test
    for (var test in testArray) {
      LicenseTypeModel? currentLicenseType = licenseTypes.where((element) => element.id == licenseId).firstOrNull;

      test.finishedCount = finishedQuestions.where((element) => element.testId == test.id).length;
      test.exactCount = finishedQuestions.where((element) => (element.testId == test.id) && (element.selectedIndex == element.answerIndex)).length;
      test.licenseType = currentLicenseType;
      if (finishedTest.map((e) => e.id).contains(test.id)) {
        test.status = 1;
      }
    }
  }

  void goToTestPage(int index) {
    var finishedQuestion = finishedQuestions.where((element) => element.testId == index);
    TestModel selectedTest = testArray[index];

    List<String> selectedQuestionIDs = selectedTest.questionIds.map((e) => '${e}').toList();
    List<QuestionModel> questionsInTest = questionList.where((element) => selectedQuestionIDs.contains('${element.id}')).toList();

    AdHelper.showAds(dismiss: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TestPage(
                test: testArray[index],
                finishedQuestionList: finishedQuestion.toList(),
                questionList: questionsInTest,
              ))
      ).then(onGoBack);
    });

  }

  onGoBack(dynamic value) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Thi thử'),
          backgroundColor: AppColors.mainColor,
          actions: [
            Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: const BorderRadius.all(Radius.circular(6))
              ),
              child: TextButton(
                  onPressed: () {
                    generateRandomTest();
                  },
                  child: const Text('Thi ngẫu nhiên').w400().text15().whiteColor()
              )
            )
          ],
        ),
        body: FutureBuilder(
          future: loadTheoryData(),
          builder: (context, snapshot) {
            return Container(
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              child: GridView.builder(
                  itemCount: testArray.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 6,
                      crossAxisSpacing: 6),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        goToTestPage(index);
                      },
                      child: TestRow(testModel: testArray[index]),
                    );
                  }
                  )
            );
          },
        )
    );
  }
}