
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
  int testId = -1;
  String questionOnTestId = '';

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
    required this.testId,
    required this.questionOnTestId,
  });

  QuestionModel.fromJson(Map<String, dynamic> json, int? testId) {
    id = json['id'];
    chapterId = json['chapterId'];
    questionText = json['questionText'];
    answerIndex = json['answerIndex'];
    questionImage = json['questionImage'];
    answerList = json['answerList'];
    isDeadPoint = json['isDeadPoint'];
    comment = json['comment'];
    if (testId != null) {
      this.testId = testId;
    }
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
    if (json['questionOnTestId'] != null) {
      questionOnTestId = json['questionOnTestId'];
    }
    if (json['testId'] != null) {
      testId = json['testId'];
    }
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
    data['testId'] = testId;
    if (questionOnTestId.isNotEmpty) {
      data['questionOnTestId'] = questionOnTestId;
    }

    return data;
  }
}