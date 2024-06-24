
import 'package:flutter/material.dart';
import 'package:license/_gen/assets.gen.dart';
import 'package:license/ads/ads_helper.dart';
import 'package:license/common/app_colors.dart';
import 'package:license/common/base/base_app_bar.dart';
import 'package:license/test/horizontal_tab.dart';
import 'package:license/theory/models/theory_question_model.dart';
import 'package:license/theory/question_detail.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key, required this.questionList, required this.title});
  final List<QuestionModel> questionList;
  final String title;

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
        appBar: BaseAppBar(
          title: widget.title,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Align(
              alignment: Alignment.center,
              child: Assets.icon.arrowBack.svg(width: 24, height: 24),
            ),
          ),
        ),
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