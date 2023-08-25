import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:license/ads/ads_helper.dart';
import 'package:license/firebase/firebase_user.dart';
import 'package:license/more/more.dart';
import 'package:license/setting/setting.dart';
import 'package:license/test/test_list.dart';
import 'package:license/theory/chapter_list.dart';
import 'package:license/theory/models/theory_question_model.dart';
import 'package:license/trafficSign/traffic_sIgn.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    // TODO: implement initState
    super.initState();
    AdHelper ads = AdHelper();

    ads.initGoogleMobileAds();
    ads.loadGoogleAds();

    FirebaseUser.instance.addUser();
    FirebaseUser.instance.updateLastTime();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getAllQuestion(),
        builder: (context, item) {
        widgetOptions = [
          ChapterList(questionList: questionList),
          const TestList(),
          const TrafficSign(),
          More(),
          const SettingScreen()];
          return Scaffold(
            body: Center(
              child: widgetOptions.elementAt(_selectedIndex),
            ),
            bottomNavigationBar: BottomNavigationBar(
              showUnselectedLabels: true,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Lý thuyết',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.school),
                  label: 'Thi thử',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.traffic),
                  label: 'Biển báo',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.warning),
                  label: 'Tiện ích',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Cài đặt',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.green,
              unselectedItemColor: Colors.grey,
              unselectedLabelStyle: const TextStyle(
                fontSize: 12
              ),
              selectedLabelStyle: const TextStyle(
                  fontSize: 14,
                fontWeight: FontWeight.w700
              ),
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