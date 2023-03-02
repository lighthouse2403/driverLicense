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
              HomeCellWidget(text: 'Thi thử', icon: 'assets/home/examination.png', type: 0),
              HomeCellWidget(text: 'Biển báo', icon: 'assets/home/examination.png', type: 1),
              HomeCellWidget(text: 'Lý thuyết', icon: 'assets/home/examination.png', type: 2),
              HomeCellWidget(text: 'Câu hay sai', icon: 'assets/home/examination.png', type: 3),
              HomeCellWidget(text: 'Lý thuyết', icon: 'assets/home/examination.png', type: 4),
              HomeCellWidget(text: 'Diễn đàn', icon: 'assets/home/examination.png', type: 5)
            ],
          )
      ),
    );
  }
}