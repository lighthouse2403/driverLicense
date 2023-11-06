import 'package:flutter/material.dart';
import 'package:license/common/app_colors.dart';
import 'package:license/common/base/base_app_bar.dart';
import 'package:license/test/horizontal_tab.dart';
import 'package:license/theory/models/theory_question_model.dart';
import 'package:license/theory/question_detail.dart';

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
        appBar: BaseAppBar(title: '${widget.questionList.length} Câu điểm liệt'),
        body: Column(
          children: [
            Container(child: horizontalTab),
            Container(height: 0.5, color: AppColors.mainColor),
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