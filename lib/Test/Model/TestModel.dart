
class TestModel {
  int id = 0 ;
  int status = 0;
  List questionIds = [];
  int finishedCount = 0;
  int total = 30;
  bool hasDeadthPoint = false;

   TestModel({
    required this.id,
    required this.status,
    required this.finishedCount,
    required this.total,
    required this.hasDeadthPoint,
  });

  TestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    questionIds = json['questionIds'];
    finishedCount = json['finishedCount'];
    total = json['total'];
    hasDeadthPoint = json['hasDeadthPoint'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['finishedCount'] = finishedCount;
    data['total'] = total;
    data['hasDeadthPoint'] = hasDeadthPoint;

    return data;
  }
}