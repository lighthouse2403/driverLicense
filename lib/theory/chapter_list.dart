import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:license/ads/ads_helper.dart';
import 'package:license/common/base/base_app_bar.dart';
import 'package:license/database/sql_helper.dart';
import 'package:license/theory/models/chapter_model.dart';
import 'package:license/theory/models/theory_question_model.dart';
import 'package:license/theory/question_page.dart';
import 'package:license/theory/theory_row.dart';

class ChapterList extends StatefulWidget {
  ChapterList({super.key, required this.questionList});

  @override
  State<ChapterList> createState() => _ChapterListState();
  List<QuestionModel> questionList = [];
}

class _ChapterListState extends State<ChapterList> {
  List<ChapterModel> chapterArray = [];

  Future<void> loadTheoryData() async {
    var finishedQuestions = await SQLHelper.getAllQuestion('questions');
    final String theoryResponse = await rootBundle.loadString('assets/json/theory.json');
    final theoryData = await json.decode(theoryResponse);
    chapterArray = List<ChapterModel>.from(theoryData["chapters"].map((json) => ChapterModel.fromJson(json)));
    ChapterModel deathPointChapter = ChapterModel(
        id: chapterArray.length + 1,
        name: '60 Câu điểm liệt',
        comment: 'Có ít nhất 1 câu điểm liệt trong đề thi. Nếu làm sai bạn sẽ bị trượt.',
        count: 60,
        finishedCount: finishedQuestions.where((element) => element.isDeadPoint).length);
    chapterArray.add(deathPointChapter);

    for (var chapter in chapterArray) {
      chapter.finishedCount = finishedQuestions.where((element) => element.chapterId == chapter.id).length;
      if (chapter.id == chapterArray.length) {
        var questions = finishedQuestions.where((element) => element.isDeadPoint).toList();

        chapter.finishedCount = questions.length;
      }
    }

    for (var element in widget.questionList) {
        var newElement = finishedQuestions.where((newElement) => newElement.id == element.id).first;
        element.selectedIndex = newElement.selectedIndex;
    }
  }

  void goToQuestionPage(int chapterId) {
    var questions =  widget.questionList.where((element) => element.chapterId == chapterId).toList();
    ChapterModel chapter = chapterArray.where((element) => element.id == chapterId).first;
    if (chapterId == chapterArray.last.id) {
      // Death point
      questions = widget.questionList.where((element) => element.isDeadPoint).toList();
      chapter = chapterArray.last;
    }

    AdHelper.showAds(dismiss: () {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => QuestionPage(questionList: questions, title: chapter.name,))
      ).then(onGoBack);
    });
  }

  onGoBack(dynamic value) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(title: 'Lý thuyết'),
      body: FutureBuilder(
        future: loadTheoryData(),
        builder: (context, snapshot) {
          return ListView.separated(
            itemCount: chapterArray.length,
            itemBuilder: (BuildContext context, int index) {
              var row = TheoryRow(theory: chapterArray[index], onTap: goToQuestionPage);
              return row;
            },
            separatorBuilder: (BuildContext context, int index) {
              return Container(height: 0.5, color: Colors.grey,);
            },
          );
        },
      )
    );
  }
}