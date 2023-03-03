import 'package:flutter/material.dart';
import 'Widget/HomeCellWidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ôn thi GPLX'),
        backgroundColor: Colors.green,
      ),
      body: Center(
          child: GridView.count(
            primary: false,
            padding: const EdgeInsets.all(16),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            crossAxisCount: 2,
            children: const <Widget>[
              HomeCellWidget(text: 'Thi thử', icon: 'examination.png', type: 0),
              HomeCellWidget(text: 'Biển báo', icon: 'trafficSign.png', type: 1),
              HomeCellWidget(text: 'Lý thuyết', icon: 'document.png', type: 2),
              HomeCellWidget(text: 'Câu hay sai', icon: 'wrongAnswer.png', type: 3),
              HomeCellWidget(text: 'Mẹo', icon: 'tips.png', type: 4),
              HomeCellWidget(text: 'Diễn đàn', icon: 'conversation.png', type: 5)
            ],
          )
      ),
    );
  }
}