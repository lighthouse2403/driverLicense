
class TheoryModel {
  int id = 0 ;
  String name = '';
  String comment = '';

  TheoryModel({
    required this.id,
    required this.name,
    required this.comment,
  });

  TheoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['comment'] = comment;
    return data;
  }
}