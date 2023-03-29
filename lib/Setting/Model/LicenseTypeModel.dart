
class LicenseTypeModel {
  int id = 0 ;
  String name = '';
  String comment = '';
  int count = 0;

  LicenseTypeModel({
    required this.id,
    required this.name,
    required this.comment,
    required this.count,
  });

  LicenseTypeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    comment = json['comment'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['comment'] = comment;
    data['count'] = count;

    return data;
  }
}