import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:license/chat/comment_model.dart';
import 'package:license/firebase/firebase_user.dart';
import 'package:license/more/model/thread_model.dart';

class FirebaseChat {
  FirebaseChat._();

  static final instance = FirebaseChat._();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  int threadLimit = 0;
  int commentLimit = 0;

  Future<List<ThreadModel>> loadThread() async {
    threadLimit += 50;

    QuerySnapshot chatSnapshot = await firestore.collection('chat').limit(threadLimit).orderBy('updateTime', descending: true).get();

    // Get data from docs and convert map to List
    final allData = chatSnapshot.docs.map((doc) => ThreadModel.fromJson(doc.data() as Map<String, dynamic>)).toList();

    return allData;
  }

  Future<void> addNewThread(String title) async {
    CollectionReference chat = firestore.collection('chat');
    List<String> deviceInfo = await FirebaseUser.instance.getDeviceDetails();

    chat.add({
        'createTime': FieldValue.serverTimestamp(),
        'threadId': FieldValue.serverTimestamp().toString(),
        'title': title,
        'updateTime': FieldValue.serverTimestamp(),
        'deviceId': deviceInfo[3],
        'deviceName': deviceInfo[1],
        'os': deviceInfo.firstOrNull,
        'deviceVersion': deviceInfo[2],
    }).then((value) async {
      await editThreadId(value.id);
    }).catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> editThread(String threadId, String newTitle) async {
    CollectionReference chat = firestore.collection('chat');
    List<String> deviceInfo = await FirebaseUser.instance.getDeviceDetails();
    var docSnapshot = await chat.where('author', isEqualTo: deviceInfo[1]).get();
  }

  Future<void> editThreadId(String threadId) async {
    CollectionReference chat = firestore.collection('chat');
    await chat.doc(threadId).update({
      'threadId' : threadId
    });
  }

  Future<List<CommentModel>> loadComment(String threadId) async {
    commentLimit += 10;

    QuerySnapshot chatSnapshot = await firestore.collection('chat').doc(threadId).collection('comments').limit(commentLimit).orderBy('updateTime', descending: true).get();

    // Get data from docs and convert map to List
    final allData = chatSnapshot.docs.map((doc) => CommentModel.fromJson(doc.data() as Map<String, dynamic>)).toList();

    print(allData.length);
    return allData;
  }

  Future<void> addNewComment(String threadId, String content) async {
    CollectionReference chat = firestore.collection('chat');
    List<String> deviceInfo = await FirebaseUser.instance.getDeviceDetails();
    var comment = await chat.doc(threadId).collection('comments');
    await comment.add({
      'commentId': FieldValue.serverTimestamp().toString(),
      'threadId': threadId,
      'os': deviceInfo.firstOrNull,
      'deviceName': deviceInfo[1],
      'deviceVersion': deviceInfo[2],
      'deviceId': deviceInfo[3],
      'content': content,
      'updateTime': FieldValue.serverTimestamp(),
      'createTime': FieldValue.serverTimestamp()
    }).then((value) async {
      await updateComment(threadId, value.id, content);
    }).catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> updateComment(String threadId, String commentId, String newComment) async {
    var comment = firestore.collection('chat').doc(threadId).collection('comments').doc(commentId);
    comment.update({
      'updateTime': FieldValue.serverTimestamp(),
      'content': newComment,
      'commentId': commentId
    }).then((_) => print('Success')).catchError((error) => print('Failed: $error'));
  }
}