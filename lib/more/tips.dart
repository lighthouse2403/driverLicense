import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:license/more/theory_tip.dart';

class Tips extends StatelessWidget {
  Tips({super.key});

  List<TheoryTipModel> tips = [];

  Future<void> loadTips() async {
    final String theoryResponse = await rootBundle.loadString('assets/json/tips.json');
    final theoryTipData = await json.decode(theoryResponse);
    tips = List<TheoryTipModel>.from(theoryTipData["theory_tips"].map((json) {
      return TheoryTipModel.fromJson(json);
    }));
    print('tips ${tips.length}');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadTips(),
        builder: (context, snapshot) {
          return Container(color: Colors.white);
        });
  }
}