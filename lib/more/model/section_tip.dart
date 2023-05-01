
class SectionTipModel {
  String name = '';
  String content = '';
  List<String> answer = [];

  SectionTipModel({
    required this.name,
    required this.content,
    required this.answer,
  });

  SectionTipModel.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    name = json['name'];
    List answerJson = json['answer'];
    answer = List<String>.from(answerJson.map((answerString) {
      return answerString;
    }));
  }
}