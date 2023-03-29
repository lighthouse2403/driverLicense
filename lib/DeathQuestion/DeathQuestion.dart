import 'package:flutter/material.dart';
import 'package:license/Theory/Model/QuestionModel.dart';
import 'package:license/Theory/questionDetail.dart';

import '../Test/HorizontalTab.dart';

class DeathQuestionPage extends StatefulWidget {
  const DeathQuestionPage({super.key, required this.questionList});
  final List<QuestionModel> questionList;

  @override
  State<DeathQuestionPage> createState() => _DeathQuestionPageState();
}

class _DeathQuestionPageState extends State<DeathQuestionPage> {
  var currentPage = 1;
  double screenWidth = WidgetsBinding.instance.window.physicalSize.width/WidgetsBinding.instance.window.devicePixelRatio;
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  void onPageChanged(int index) {
    setState(() {
      currentPage = index + 1;
    });
  }

  void jumToIndex(int index) {
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('${widget.questionList.length} Câu điểm liệt'),
          backgroundColor: Colors.green,
        ),
        body: Column(
          children: [
            HorizontalTab(
                length: widget.questionList.length,
                currentPage: currentPage,
                callback: jumToIndex,
                width: screenWidth/4),
            Container(height: 0.5, color: Colors.green,),
            Expanded(
                child: Container(
                  color: Colors.white,
                  child: PageView.builder(
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