import 'package:flutter/material.dart';
import 'package:license/common/app_colors.dart';
import 'package:license/extension/text_extension.dart';
import 'package:license/more/model/section_tip.dart';

class TheorySectionContentRow extends StatelessWidget {
  const TheorySectionContentRow({super.key, required this.sectionTipsModel});

  final SectionTipModel sectionTipsModel;

  @override
  Widget build(BuildContext context) {
    List<Container> answer = sectionTipsModel.answer.map((e) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Text(
          '  - $e',
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 17,
            color: Colors.black
          ),
        ),
      );
    }).toList();

    List<Container> children = [
      Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Text(
          sectionTipsModel.name,
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: AppColors.mainColor,
          ),
        ),
      ),
      sectionTipsModel.content.isNotEmpty
          ? Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Text(
                sectionTipsModel.content,
                style: const TextStyle(
                  height: 1.4,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Colors.black
                ),
              ).w500().text18().blackColor().customHeight(1.5),
            )
          : Container()
    ];

    children.addAll(answer);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }
}