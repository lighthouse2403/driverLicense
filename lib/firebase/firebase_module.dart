import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:license/firebase_options.dart';

class FirebaseModule {
  FirebaseModule._();

  static final instance = FirebaseModule._();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  Future<void> addUser() async {
    CollectionReference users = FirebaseFirestore.instance.collection('user');
    List<String> deviceInfo = await getDeviceDetails();

    return
      users.doc(deviceInfo[3]).set({
        'os': deviceInfo.firstOrNull,
        'deviceName': deviceInfo[1],
        'deviceVersion': deviceInfo[2],
        'deviceId': deviceInfo[3],
        'firstTime': DateTime.now().millisecondsSinceEpoch
      }).then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> updateLastTime() async {
    CollectionReference users = FirebaseFirestore.instance.collection('user');

    List<String> deviceInfo = await getDeviceDetails();

    users.doc(deviceInfo[3])
        .update({'lastTime' : DateTime.now().millisecondsSinceEpoch})
        .then((_) => print('Success'))
        .catchError((error) => print('Failed: $error'));
  }

  Future<List<String>> getDeviceDetails() async {
    String os = Platform.operatingSystem;
    String deviceName = '';
    String deviceVersion = '';
    String identifier = '';
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceName = build.model;
        deviceVersion = build.version.toString();
        identifier = build.androidId;  //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceName = data.name;
        deviceVersion = data.systemVersion;
        identifier = data.identifierForVendor;  //UUID for iOS
      }
    } on PlatformException {
      print('Failed to get platform version');
    }
    return [os, deviceName, deviceVersion, identifier];
  }
}