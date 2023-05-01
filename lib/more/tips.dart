import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:license/more/model/theory_tip.dart';

import 'child_view/section_tip.dart';

class Tips extends StatelessWidget {
  Tips({super.key});

  List<TheoryTipModel> tips = [];

  Future<void> loadTips() async {
    final String theoryResponse = await rootBundle.loadString('assets/json/tips.json');
    final theoryTipData = await json.decode(theoryResponse);
    tips = List<TheoryTipModel>.from(theoryTipData["theory_tips"].map((json) {
      return TheoryTipModel.fromJson(json);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          'Mẹo thi lý thuyết',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white
          ),
        ),
      ),
      body: FutureBuilder(
          future: loadTips(),
          builder: (context, snapshot) {
            return Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ListView.builder(
                    itemCount: tips.length,
                    itemBuilder: (context, index) {
                      return SectionTip(
                        tipModel: tips[index],
                      );
                    })
            );
          }
          )
    );
  }
}