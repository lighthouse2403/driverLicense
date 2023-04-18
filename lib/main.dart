import 'package:flutter/material.dart';
import 'package:license/bottomTabBar/bottomTabBar.dart';

void main() {
  runApp(const DriverLicense());
}

class DriverLicense extends StatelessWidget {
  const DriverLicense({super.key});
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


