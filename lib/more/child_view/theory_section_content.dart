import 'package:flutter/material.dart';
import 'package:license/more/child_view/theory_section_content_row.dart';
import 'package:license/more/model/section_tip.dart';

class TheorySectionContent extends StatelessWidget {
  const TheorySectionContent({super.key, required this.sectionTipsModel});

  final List<SectionTipModel> sectionTipsModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Mẹo',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Colors.white
          ),
        ),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: sectionTipsModel.length,
          itemBuilder: (context, index) {
            return TheorySectionContentRow(sectionTipsModel: sectionTipsModel[index]);
          }
      ),
    );
  }
}