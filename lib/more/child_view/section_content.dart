import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:license/more/model/section_tip.dart';
import 'package:license/more/model/theory_tip.dart';

class SectionContent extends StatelessWidget {
  SectionContent({super.key, required this.sectionModel});

  SectionTipModel sectionModel;

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: Text(
          sectionModel.name,
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500
          ),
        )
    );
  }
}