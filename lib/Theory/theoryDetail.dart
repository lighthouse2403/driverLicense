import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TheoryDetail extends StatefulWidget {
  const TheoryDetail({super.key, required this.type});
  final int type;

  @override
  State<TheoryDetail> createState() => _TheoryDetailState();
}

class _TheoryDetailState extends State<TheoryDetail> {
  List traficSignArray = [];

  Future<void> loadTrafficSignData() async {
    final String response = await rootBundle.loadString('assets/json/trafficSign.json');
    final data = await json.decode(response);
    print(data.toString());
    setState(() {
      traficSignArray = data["trafficSign"];
    });
    print(data.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadTrafficSignData();
  }

  @override
  Widget build(BuildContext context) {
    return Text('Lý thuyết');
  }
}