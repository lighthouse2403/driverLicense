
class ChapterModel {
  int id = 0 ;
  String name = '';
  String comment = '';
  int count = 0;
  int finishedCount = 0;

  ChapterModel({
    required this.id,
    required this.name,
    required this.comment,
    required this.count,
    required this.finishedCount,

  });

  ChapterModel.fromJson(Map<String, dynamic> json) {
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
    data['finishedCount'] = finishedCount;

    return data;
  }
}