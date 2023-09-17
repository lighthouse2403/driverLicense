import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:license/bottom_tab_bar/bottom_tab_bar.dart';
import 'package:license/firebase/firebase_user.dart';
import 'package:license/firebase/firebase_option.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const DriverLicense());
}

class DriverLicense extends StatelessWidget {
  const DriverLicense({super.key});

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
  FirebaseAnalyticsObserver(analytics: analytics);

  void saveUserLog() async {
    await FirebaseUser.instance.addUser();
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'GPLX ô tô',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainBottomTabBar(),
    );
  }
}


