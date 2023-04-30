import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:license/bottomTabBar/bottomTabBar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      name: 'Driver license',
      options: DefaultFirebaseOptions.currentPlatform,
    ).whenComplete(() {
      print("completedAppInitialize");
    });
  }
  runApp(const DriverLicense());
}

class DriverLicense extends StatelessWidget {
  const DriverLicense({super.key});

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
  FirebaseAnalyticsObserver(analytics: analytics);

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


