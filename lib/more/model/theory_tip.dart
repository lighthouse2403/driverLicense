import 'package:license/more/model/section_tip.dart';

class TheoryTipModel {
  int id = 0;
  String name = '';
  List<SectionTipModel> section = [];

  TheoryTipModel({
    required this.id,
    required this.name,
    required this.section,
  });

  TheoryTipModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    List<dynamic> sectionJson = json['section'];

    section = List<SectionTipModel>.from(sectionJson.map((section) {
      return SectionTipModel.fromJson(section);
    }));
  }
}