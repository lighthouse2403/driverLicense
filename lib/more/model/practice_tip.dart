
class PracticeTipModel {
  int id = 0;
  String name = '';
  String comment = '';

  PracticeTipModel({
    required this.id,
    required this.name,
    required this.comment,
  });

  PracticeTipModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    comment = json['comment'];
  }
}