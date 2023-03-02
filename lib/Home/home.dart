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
              HomeCellWidget(text: 'Thi thử', icon: 'assets/home/examination.png'),
              HomeCellWidget(text: 'Biển báo', icon: 'assets/home/examination.png'),
              HomeCellWidget(text: 'Lý thuyết', icon: 'assets/home/examination.png'),
              HomeCellWidget(text: 'Câu hay sai', icon: 'assets/home/examination.png'),
              HomeCellWidget(text: 'Lý thuyết', icon: 'assets/home/examination.png'),
              HomeCellWidget(text: 'Diễn đàn', icon: 'assets/home/examination.png')
            ],
          )
      ),
    );
  }
}