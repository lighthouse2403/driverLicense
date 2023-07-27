import 'package:license/setting/model/license_model.dart';

class TestModel {
  int id = 0 ;
  int status = 0;
  List questionIds = [];
  int finishedCount = 0;
  int exactCount = 0;
  int total = 30;
  bool hasDeadthPoint = false;
  LicenseTypeModel? licenseType;

   TestModel({
      required this.id,
      required this.status,
      required this.finishedCount,
      required this.total,
      required this.hasDeadthPoint,
     required this.licenseType
  });

  TestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    questionIds = json['questionIds'];
    finishedCount = json['finishedCount'];
    total = json['total'];
    hasDeadthPoint = json['hasDeadthPoint'];

    if (json['exactCount'] != null) {
      exactCount = json['exactCount'];
    }
  }

  TestModel.fromDatabase(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    questionIds = json['questionIds'].split('--');
    finishedCount = json['finishedCount'];
    total = json['total'];
    hasDeadthPoint = json['hasDeadthPoint'] == 0 ? false : true;
    if (json['exactCount'] != null) {
      exactCount = json['exactCount'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['finishedCount'] = finishedCount;
    data['total'] = total;
    data['hasDeadthPoint'] = hasDeadthPoint ? 1 : 0;
    data['exactCount'] = exactCount;
    data['questionIds'] = questionIds.join('--');
    data['licenseId'] = licenseType?.id;

    return data;
  }
}