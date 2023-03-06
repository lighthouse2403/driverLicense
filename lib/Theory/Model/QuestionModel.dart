
import 'dart:ffi';

class QuestionModel {
  int id = 0 ;
  int chapterId = 0;
  String questionText = '';
  int answerIndex = 0;
  String questionImage = '';
  List answerList = [];
  bool isDeadPoint = false;
  String comment = '';

  QuestionModel({
    required this.id,
    required this.chapterId,
    required this.questionText,
    required this.answerIndex,
    required this.questionImage,
    required this.answerList,
    required this.isDeadPoint,
    required this.comment
  });

  QuestionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    chapterId = json['chapterId'];
    questionText = json['questionText'];
    answerIndex = json['answerIndex'];
    questionImage = json['questionImage'];
    answerList = json['answerList'];
    isDeadPoint = json['isDeadPoint'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['chapterId'] = chapterId;
    data['questionText'] = questionText;
    data['answerIndex'] = answerIndex;
    data['questionImage'] = questionImage;
    data['answerList'] = answerList;
    data['isDeadPoint'] = isDeadPoint;
    data['comment'] = comment;
    return data;
  }
}