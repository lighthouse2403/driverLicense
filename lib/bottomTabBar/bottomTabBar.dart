import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:license/Ads/adsHelper.dart';
import 'package:license/DeathQuestion/DeathQuestion.dart';
import 'package:license/Setting/setting.dart';
import 'package:license/Test/TestList.dart';
import 'package:license/Theory/ChapterList.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Theory/Model/QuestionModel.dart';
import '../trafficSign/trafficSIgn.dart';

class MainBottomTabBar extends StatefulWidget {
  const MainBottomTabBar({super.key});

  @override
  State<MainBottomTabBar> createState() => MainBottomTabBarState();
}

class MainBottomTabBarState extends State<MainBottomTabBar> {
  int _selectedIndex = 0;
  List<Widget> widgetOptions = [];
  List<QuestionModel> questionList = [];

  Future<void> getAllQuestion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getInt('licenseType') == null) {
      prefs.setInt('licenseType', 2);
    }

    final String questionResponse = await rootBundle.loadString('assets/json/questions.json');
    final questionData = await json.decode(questionResponse);
    questionList = List<QuestionModel>.from(questionData["questions"].map((json) => QuestionModel.fromJson(json, null)));
  }

  @override
  void initState() {
    print('initState');
    // TODO: implement initState
    super.initState();
    AdHelper ads = AdHelper();

    ads.initGoogleMobileAds();
    ads.loadGoogleAds();
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: getAllQuestion(),
        builder: (context, item) {
        List<QuestionModel> deathQuestions = questionList.where((element) => element.isDeadPoint).toList();

        widgetOptions = [
          ChapterList(questionList: questionList,),
          const TestList(),
          DeathQuestionPage(questionList: deathQuestions),
          const TrafficSign(),
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
                  icon: Icon(Icons.school),
                  label: 'Thi thử',
                  backgroundColor: Colors.green,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.warning),
                  label: 'Câu liệt',
                  backgroundColor: Colors.green,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.forum),
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
              selectedItemColor: Colors.white,
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