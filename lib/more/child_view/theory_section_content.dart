import 'package:flutter/material.dart';
import 'package:license/_gen/assets.gen.dart';
import 'package:license/common/app_colors.dart';
import 'package:license/common/base/base_app_bar.dart';
import 'package:license/more/child_view/theory_section_content_row.dart';
import 'package:license/more/model/section_tip.dart';

class TheorySectionContent extends StatelessWidget {
  const TheorySectionContent({super.key, required this.sectionTipsModel});

  final List<SectionTipModel> sectionTipsModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Mẹo',
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Align(
            alignment: Alignment.center,
            child: Assets.icon.arrowBack.svg(width: 24, height: 24),
          ),
        ),
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