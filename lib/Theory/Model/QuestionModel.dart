
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
  int selectedIndex = -1;

  QuestionModel({
    required this.id,
    required this.chapterId,
    required this.questionText,
    required this.answerIndex,
    required this.questionImage,
    required this.answerList,
    required this.isDeadPoint,
    required this.comment,
    required this.selectedIndex,
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

  QuestionModel.fromDatabase(Map<String, dynamic> json) {
    id = json['id'];
    chapterId = json['chapterId'];
    questionText = json['questionText'];
    answerIndex = json['answerIndex'];
    questionImage = json['questionImage'];
    answerList = json['answerList'].split('--');
    comment = json['comment'];
    selectedIndex = json['selectedIndex'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['chapterId'] = chapterId;
    data['questionText'] = questionText;
    data['answerIndex'] = answerIndex;
    data['questionImage'] = questionImage;
    data['answerList'] = answerList.join('--');
    data['comment'] = comment;
    data['selectedIndex'] = selectedIndex;

    return data;
  }
}