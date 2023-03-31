import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:license/Database/sqlHelper.dart';
import 'package:license/Test/HorizontalTab.dart';
import 'package:license/Test/Model/TestModel.dart';
import 'package:license/Test/TimeWidget.dart';
import '../Theory/Model/QuestionModel.dart';
import 'ResultButton.dart';
import 'TestDetail.dart';
import 'TestResult.dart';

enum TestStatus {
  none,
  testing,
  done,
}

class TestPage extends StatefulWidget {
  TestPage({super.key, required this.test, required this.finishedQuestionList});
  // final TestModel test;
  TestModel test;
  List<QuestionModel> finishedQuestionList = [];

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  var currentPage = 1;
  List<QuestionModel> questionList = [];
  Timer? countdownTimer;
  Duration testingDuration = const Duration(minutes: 22);
  TestStatus status = TestStatus.none;
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );
  double screenWidth = WidgetsBinding.instance.window.physicalSize.width/WidgetsBinding.instance.window.devicePixelRatio;
  HorizontalTab? horizontalTab;

  @override
  void dispose() {
    if (countdownTimer != null) {
      countdownTimer?.cancel();
      countdownTimer = null;
    }
    super.dispose();
  }

  void onPageChanged(int index) {
    horizontalTab?.animateToIndex(index);
    setState(() {
      currentPage = index + 1;
    });
  }

  void jumToIndex(int index) {
    pageController.jumpToPage(index);
  }

  void backFromResult(int index) {
    jumToIndex(index);
    onPageChanged(index);
  }

  void startTimer() {
    testingDuration = const Duration(minutes: 22);
    setState(() {
      countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
    });
  }
  
  // Step 4
  void stopTimer() {
      setState(() => countdownTimer!.cancel());
  }

  // Step 6
  void setCountDown() {
    const reduceSecondsBy = 1;
    if (status != TestStatus.testing) {
      stopTimer();
      return;
    }
    setState(() {
      final seconds = testingDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        finishedTesting();
      } else {
        testingDuration = Duration(seconds: seconds);
      }
    });
  }

  void startTesting() {
    status = TestStatus.testing;
    startTimer();
  }

  void reTest() async {
    status = TestStatus.none;
    stopTimer();
    SQLHelper.deleteAllQuestionOnTest(widget.test.id);
    await getQuestionList();
    status = TestStatus.testing;
    currentPage = 1;
    pageController.jumpToPage(0);
    startTimer();
  }

  void updateQuestion(QuestionModel question) {
    for (var element in questionList) {
        if (element.id == question.id) {
          element = question;
          break;
        }
    }
  }

  Future<void> finishedTesting() async {
    status = TestStatus.done;
    SQLHelper().insertTest(widget.test);
    stopTimer();
  }

  Future<void> getQuestionList() async {
    if (status != TestStatus.none) {
      return;
    }

    final String questionResponse = await rootBundle.loadString('assets/json/questions.json');
    final questionData = await json.decode(questionResponse);
    questionList = List<QuestionModel>.from(questionData["questions"].map((json) => QuestionModel.fromJson(json, null))).where((element) => widget.test.questionIds.contains(element.id)).toList();

    for (var question in questionList) {
      if (widget.finishedQuestionList.where((element) => (element.id == question.id) && element.testId == widget.test.id ).isNotEmpty) {
          question = widget.finishedQuestionList.where((element) => element.id == question.id).first;
      }
    }
  }

  void gotoTestResult() async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TestResult(
              questions: questionList,
              test: widget.test)
        )
    ).then((index) => backFromResult(index));
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = strDigits(testingDuration.inMinutes.remainder(60));
    final seconds = strDigits(testingDuration.inSeconds.remainder(60));
    var testStatus = 'Bắt đầu';

    switch (status) {
      case TestStatus.testing:
        testStatus = 'Kết thúc';
        break;
      case TestStatus.done:
        testStatus = 'Làm lại';
        break;
      case TestStatus.none:
        testStatus = 'Bắt đầu';
        break;
    }
    return Scaffold(
        appBar: AppBar(
          actions: [
            Center(
              child:  Container(
                margin: const EdgeInsets.only(right: 10),
                height: 36,
                decoration: BoxDecoration(
                  color: ((testingDuration.inSeconds % 2) == 0) ? Colors.orangeAccent.withOpacity(0.5) : Colors.orangeAccent.withOpacity(0.8),
                  borderRadius: const BorderRadius.all(Radius.circular(6))
                ),
                child: TextButton(
                    onPressed: () {
                      switch (status) {
                        case TestStatus.none:
                          startTesting();
                          break;
                        case TestStatus.testing:
                          finishedTesting();
                          gotoTestResult();
                          break;
                        case TestStatus.done:
                          reTest();
                          break;
                        default:
                          stopTimer();
                          break;
                      }
                    },
                    child: Text(
                      testStatus,
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white),
                    )
                ),
              )
            )
          ],
          title: GestureDetector(
            onTap: () {
              if (status == TestStatus.done) {
                gotoTestResult();
              }
            },
            child: status == TestStatus.done ? ResultButton() : TimeWidget(minutes: minutes,seconds: seconds,)
          ),
          backgroundColor: Colors.green,
        ) ,
        body: FutureBuilder(
          future: getQuestionList(),
          builder: (context, snapshot) {
            horizontalTab = HorizontalTab(
              length: widget.test.questionIds.length,
              currentPage: currentPage,
              callback: jumToIndex,
              width: screenWidth/4,
            );
            return Column(
              children: [
                Container(child: horizontalTab),
                Container(height: 0.5, color: Colors.green,),
                Expanded(
                    child: Container(
                      color: Colors.white,
                      child: PageView.builder(
                        controller: pageController,
                        itemCount: widget.test.questionIds.length,
                        scrollDirection: Axis.horizontal,
                        onPageChanged: onPageChanged,
                        itemBuilder: (BuildContext context, int index) {
                          return TestDetail(question: questionList[index], test: widget.test, testStatus: status, updateQuestion: updateQuestion);
                        },
                      ),
                    )
                )
              ],
            );
          },
        )
    );
  }
}