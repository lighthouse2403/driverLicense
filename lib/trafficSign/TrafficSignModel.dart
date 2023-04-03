
class TrafficSignModel {
  int type = 0;
  String name = '';
  String comment = '';
  String description = '';

  TrafficSignModel({
    required this.type,
    required this.name,
    required this.comment,
    required this.description,
  });

  TrafficSignModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    name = json['name'];
    comment = json['comment'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['name'] = name;
    data['comment'] = comment;
    data['description'] = description;
    return data;
  }
}