import 'package:flutter/material.dart';
import 'package:license/Theory/Model/QuestionModel.dart';
import 'package:license/Theory/Model/ChapterModel.dart';
import 'package:license/Theory/questionDetail.dart';

import '../Test/HorizontalTab.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key, required this.questionList, required this.chapter});
  final List<QuestionModel> questionList;
  final ChapterModel chapter;

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  var currentPage = 1;
  double screenWidth = WidgetsBinding.instance.window.physicalSize.width/WidgetsBinding.instance.window.devicePixelRatio;
  HorizontalTab? horizontalTab;

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  void onPageChanged(int index) {
    horizontalTab?.animateToIndex(index);
    setState(() {
      currentPage = index + 1;
    });
  }

  void jumToIndex(int index) {
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    horizontalTab = HorizontalTab(
      length: widget.questionList.length,
      currentPage: currentPage,
      callback: jumToIndex,
      width: screenWidth/4,
    );
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.chapter.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          backgroundColor: Colors.green,
        ),
        body: Column(
          children: [
            Container(child: horizontalTab),
            Container(height: 0.5, color: Colors.green,),
            Expanded(
                child: Container(
                  color: Colors.white,
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: widget.questionList.length,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: onPageChanged,
                    itemBuilder: (BuildContext context, int index) {
                      return QuestionDetail(question: widget.questionList[index]);
                    },
                  ),
                )
            )
          ],
        )
    );
  }
}