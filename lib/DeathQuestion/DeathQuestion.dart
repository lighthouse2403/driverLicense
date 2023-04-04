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
  HorizontalTab? horizontalTab;

  void onPageChanged(int index) {
    horizontalTab?.animateToIndex(index);
    setState(() {
      currentPage = index + 1;
    });
  }

  void jumToIndex(int index) {
    print('jumToIndex ${index}');
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    horizontalTab = HorizontalTab(
      length: widget.questionList.length,
      currentPage: currentPage,
      callback: jumToIndex,
      screenRate: 4,
      title: widget.questionList.asMap().entries.map((e) {
        return 'Câu ${e.key + 1}';
      }).toList(),
    );
    return Scaffold(
        appBar: AppBar(
          title: Text('${widget.questionList.length} Câu điểm liệt'),
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