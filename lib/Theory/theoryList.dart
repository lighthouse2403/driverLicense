import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:license/Theory/TheoryModel.dart';
import 'package:license/Theory/theoryRow.dart';
import 'package:flutter/services.dart';

class TheoryList extends StatefulWidget {
  const TheoryList({super.key});
  @override
  State<TheoryList> createState() => _TheoryListState();
}

class _TheoryListState extends State<TheoryList> {
  List chapterArray = [];

  Future<void> loadTheoryData() async {
    final String response = await rootBundle.loadString('assets/json/theory.json');
    final data = await json.decode(response);
    print(data.toString());
    setState(() {
      chapterArray = data["chapers"];
    });
    print(data.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadTheoryData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lý thuyết'),
        backgroundColor: Colors.green,
      ),
      body: ListView.separated(
        itemCount: chapterArray.length,
        itemBuilder: (BuildContext context, int index) {
          var theoryModel = TheoryModel.fromJson(chapterArray[index]);
          return TheoryRow(theory: theoryModel,);
        },
        separatorBuilder: (BuildContext context, int index) {
          return Container(height: 0.5, color: Colors.grey,);
        },
      ),
    );
  }
}