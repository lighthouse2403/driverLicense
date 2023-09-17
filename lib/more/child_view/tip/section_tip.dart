import 'package:flutter/material.dart';
import 'package:license/more/child_view/theory_section_content.dart';
import 'package:license/more/model/theory_tip.dart';

class SectionTip extends StatefulWidget {
  SectionTip({super.key, required this.tipModel});
  TheoryTipModel tipModel;

  @override
  State<SectionTip> createState() => _SectionTipState();
}

class _SectionTipState extends State<SectionTip> {

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 2),
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
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TheorySectionContent(sectionTipsModel: widget.tipModel.section))
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      widget.tipModel.name,
                      style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.black
                      ),
                    ),
                  )
              ),
              Container(
                margin: const EdgeInsets.only(right: 10),
                width: 20,
                height: 20,
                child: const Icon(Icons.keyboard_arrow_right, ),
              )
            ],
          ),
        )
    );
  }
}