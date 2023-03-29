import 'package:flutter/material.dart';

class ForumWidget extends StatefulWidget {
  const ForumWidget({super.key});

  @override
  State<ForumWidget> createState() => _ForumWidgetState();
}

class _ForumWidgetState extends State<ForumWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ôn thi GPLX'),
        backgroundColor: Colors.green,
      ),
      body: Text('Diễn đàn'),
    );
  }
}