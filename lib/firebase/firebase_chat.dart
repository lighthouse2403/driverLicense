import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:license/firebase/firebase_user.dart';
import 'package:license/more/model/thread_model.dart';

class FirebaseChat {
  FirebaseChat._();

  static final instance = FirebaseChat._();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<ThreadModel>> loadThread() async {
    QuerySnapshot chatSnapshot = await firestore.collection('chat').get();

    // Get data from docs and convert map to List
    final allData = chatSnapshot.docs.map((doc) => ThreadModel.fromJson(doc.data() as Map<String, dynamic>)).toList();

    return allData;
  }

  Future<void> addNewThread(String title) async {
    CollectionReference chat = firestore.collection('chat');
    List<String> deviceInfo = await FirebaseUser.instance.getDeviceDetails();

    chat.doc('${DateTime.now().millisecondsSinceEpoch}').set({
        'createTime': FieldValue.serverTimestamp(),
        'title': title,
        'updateTime': FieldValue.serverTimestamp(),
        'deviceId': deviceInfo[3],
      }).then((value) => print("Added new thread"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> editThread(String threadId, String newTitle) async {
    CollectionReference chat = firestore.collection('chat');
    List<String> deviceInfo = await FirebaseUser.instance.getDeviceDetails();
    var docSnapshot = await chat.where('author', isEqualTo: deviceInfo[1]).get();
  }

  Future<void> addNewComment(String threadId, String comment) async {
    CollectionReference chat = firestore.collection('chat');
    List<String> deviceInfo = await FirebaseUser.instance.getDeviceDetails();
    var comment = await chat.doc(threadId).collection('comment').doc('${DateTime.now().millisecondsSinceEpoch}');
    comment.set({
      'os': deviceInfo.firstOrNull,
      'deviceName': deviceInfo[1],
      'deviceVersion': deviceInfo[2],
      'deviceId': deviceInfo[3],
      'comment': comment,
      'updateTime': FieldValue.serverTimestamp()
    }).then((value) => print("User Added")).catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> updateComment(String threadId, String commentId, String newComment) async {
    var comment = firestore.collection('chat').doc(threadId).collection('comment').doc(commentId);
    comment.update({
      'updateTime': FieldValue.serverTimestamp(),
      'comment': newComment
    }).then((_) => print('Success')).catchError((error) => print('Failed: $error'));
  }
}