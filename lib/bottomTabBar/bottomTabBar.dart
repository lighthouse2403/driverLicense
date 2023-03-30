import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:license/DeathQuestion/DeathQuestion.dart';
import 'package:license/Forum/ForumWidget.dart';
import 'package:license/Setting/setting.dart';
import 'package:license/Test/TestList.dart';
import 'package:license/Theory/ChapterList.dart';
import '../Theory/Model/QuestionModel.dart';

class MainBottomTabBar extends StatefulWidget {
  const MainBottomTabBar({super.key});

  @override
  State<MainBottomTabBar> createState() => _MainBottomTabBarState();
}

class _MainBottomTabBarState extends State<MainBottomTabBar> {
  int _selectedIndex = 0;
  List<Widget> widgetOptions = [];
  List<QuestionModel> questionList = [];

  Future<void> getAllQuestion() async {
    final String questionResponse = await rootBundle.loadString('assets/json/questions.json');
    final questionData = await json.decode(questionResponse);
    questionList = List<QuestionModel>.from(questionData["questions"].map((json) => QuestionModel.fromJson(json, null)));
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: getAllQuestion(),
        builder: (context, item) {
        List<QuestionModel> deathQuestions = questionList.where((element) => element.isDeadPoint).toList();

        widgetOptions = [ChapterList(questionList: questionList,),
                          const TestList(),
                          DeathQuestionPage(questionList: deathQuestions),
                          const ForumWidget(),
                          const SettingScreen()];

          return Scaffold(
            body: Center(
              child: widgetOptions.elementAt(_selectedIndex),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Lý thuyết',
                  backgroundColor: Colors.green,

                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.business),
                  label: 'Thi thử',
                  backgroundColor: Colors.green,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.school),
                  label: 'Câu liệt',
                  backgroundColor: Colors.green,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Giao lưu',
                  backgroundColor: Colors.green,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Cài đặt',
                  backgroundColor: Colors.green,
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.orangeAccent,
              onTap: _onItemTapped,
            ),
          );
        });
  }

  // FUNCTION
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}