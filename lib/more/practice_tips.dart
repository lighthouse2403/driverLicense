import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:license/more/model/practice_tip.dart';
import 'package:license/more/practice_section.dart';

class PracticeTips extends StatelessWidget {
  PracticeTips({super.key});

  List<PracticeTipModel> practiceTips = [];

  Future<void> loadTips() async {
    final String theoryResponse = await rootBundle.loadString('assets/json/tips.json');
    final theoryTipData = await json.decode(theoryResponse);
    practiceTips = List<PracticeTipModel>.from(theoryTipData["practice_tips"].map((json) {
      return PracticeTipModel.fromJson(json);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadTips(),
        builder: (context, snapshot) {
          return Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ListView.builder(
                  itemCount: practiceTips.length,
                  itemBuilder: (context, index) {
                    return PracticeSection(
                      name: practiceTips[index].name,
                      comment: practiceTips[index].comment,
                    );
                  })
          );
        }
    );
  }
}