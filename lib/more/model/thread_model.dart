import 'package:cloud_firestore/cloud_firestore.dart';

class ThreadModel {
  String threadId = '';
  String userId = '';
  String title = '';
  Timestamp createTime = Timestamp(0, 0);
  Timestamp updateTime = Timestamp(0, 0);


  ThreadModel({
    required this.threadId,
    required this.userId,
    required this.title,
    required this.createTime,
    required this.updateTime,
  });

  ThreadModel.fromJson(Map<String, dynamic> json) {
    threadId = json['threadId'];
    userId = json['userId'];
    title = json['title'];
    createTime = json['createTime'];
    updateTime = json['updateTime'];
  }
}