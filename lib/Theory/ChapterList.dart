import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:license/Database/sqlHelper.dart';
import 'package:license/Theory/Model/QuestionModel.dart';
import 'package:license/Theory/Model/ChapterModel.dart';
import 'package:license/Theory/questionPage.dart';
import 'package:license/Theory/theoryRow.dart';
import 'package:flutter/services.dart';

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

    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => QuestionPage(questionList: questions, title: chapter.name,))
    ).then(onGoBack);
  }

  onGoBack(dynamic value) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lý thuyết'),
        backgroundColor: Colors.green,
      ),
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