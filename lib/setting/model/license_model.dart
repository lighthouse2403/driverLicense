

class LicenseTypeModel {
  int id = 0 ;
  String name = '';
  String comment = '';
  int testCount = 0;
  int questionCount = 0;
  int minutes = 0;
  int require = 0;

  LicenseTypeModel({
    required this.id,
    required this.name,
    required this.comment,
    required this.testCount,
    required this.questionCount,
    required this.minutes,
    required this.require,
  });

  LicenseTypeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    comment = json['comment'];
    testCount = json['testCount'];
    questionCount = json['questionCount'];
    minutes = json['minutes'];
    require = json['require'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['comment'] = comment;
    data['testCount'] = testCount;
    data['questionCount'] = questionCount;
    data['minutes'] = minutes;
    data['require'] = require;

    return data;
  }
}