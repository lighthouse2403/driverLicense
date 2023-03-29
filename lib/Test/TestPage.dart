import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:license/Database/sqlHelper.dart';
import 'package:license/Test/HorizontalTab.dart';
import 'package:license/Test/Model/TestModel.dart';
import 'package:license/Test/TimeWidget.dart';
import '../Theory/Model/QuestionModel.dart';
import 'TestDetail.dart';

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
  String result = 'Đạt';
  List<QuestionModel> questionList = [];
  Timer? countdownTimer;
  Duration testingDuration = const Duration(minutes: 1);
  TestStatus status = TestStatus.none;
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );
  ScrollController tabController = ScrollController();
  double screenWidth = WidgetsBinding.instance.window.physicalSize.width/WidgetsBinding.instance.window.devicePixelRatio;

  @override
  void dispose() {
    if (countdownTimer != null) {
      countdownTimer?.cancel();
      countdownTimer = null;
    }
    super.dispose();
  }

  void animateToIndex(int index) {
    var tabItemWidth = screenWidth/4;
    Duration duration = const Duration(milliseconds: 500);
    if ((index > 1) && ((index + 2) < widget.test.questionIds.length)) {
      tabController.animateTo((index - 1.5) * tabItemWidth, duration: duration, curve: Curves.easeOut);
    } else if (index >= widget.test.questionIds.length - 1) {
      tabController.animateTo((index - 3) * tabItemWidth, duration: duration, curve: Curves.easeOut);
    } else if (index == 0) {
      tabController.animateTo(0, duration: duration, curve: Curves.easeOut);
    } else if ((index == widget.test.questionIds.length - 2)) {
      tabController.animateTo((index - 2) * tabItemWidth, duration: duration, curve: Curves.easeOut);
    }
  }

  void onPageChanged(int index) {
    animateToIndex(index);
    setState(() {
      currentPage = index + 1;
    });
  }

  void jumToIndex(int index) {
    pageController.jumpToPage(index);
  }

  void startTimer() {
    testingDuration = const Duration(minutes: 1);
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

  Future<void> finishedTesting() async {
    status = TestStatus.done;
    SQLHelper().insertTest(widget.test);
    widget.finishedQuestionList = await SQLHelper().getAllQuestionOnTest(widget.test.id);
    for (var element in widget.finishedQuestionList) {
        if (!widget.test.questionIds.contains(element.id) || (element.selectedIndex != element.answerIndex)) {
          result = 'Trượt';
          break;
        }
    }
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
          title: status == TestStatus.done ? Text(result, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),) : TimeWidget(minutes: minutes,seconds: seconds,),
          backgroundColor: Colors.green,
        ) ,
        body: FutureBuilder(
          future: getQuestionList(),
          builder: (context, snapshot) {
            return Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                HorizontalTab(
                    length: widget.test.questionIds.length,
                    currentPage: currentPage,
                    callback: jumToIndex,
                    width: screenWidth/4),
                Container(height: 0.5, color: Colors.green,),
                Expanded(
                    child: Container(
                      height: 200,
                      color: Colors.white,
                      child: PageView.builder(
                        controller: pageController,
                        itemCount: widget.test.questionIds.length,
                        scrollDirection: Axis.horizontal,
                        onPageChanged: onPageChanged,
                        itemBuilder: (BuildContext context, int index) {
                          return TestDetail(question: questionList[index], test: widget.test, testStatus: status,);
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