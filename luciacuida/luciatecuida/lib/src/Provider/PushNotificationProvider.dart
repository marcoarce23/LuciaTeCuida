import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';

import 'package:luciatecuida/src/Model/PreferenceUser.dart';

class PushNotificationProvider {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _mensajesStreamController = StreamController<String>.broadcast();
  Stream<String> get mensajes => _mensajesStreamController.stream;
  final prefs = new PreferensUser();

  initNotifications() 
  {
    _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
        sound: true,
        alert:true,
        badge: true,
      )
    );
    _firebaseMessaging.getToken().then((token) {
      print('===== FCM Token =====');
      prefs.token = token;
      print('tokennnn: ${prefs.token}');
    });

    _firebaseMessaging.configure(onMessage: (info) {
      print('======= On Message ========');
      print(info);

      String argumento = 'no-data';
      if (Platform.isAndroid) {
        argumento = info['data']['ayuda'] ?? 'no-data';
      } else {
        argumento = info['ayuda'] ?? 'no-data-ios';
      }

      _mensajesStreamController.sink.add(argumento);
      // final snackbar = SnackBar(
      //   content: Text(argumento),
      //   action: SnackBarAction(label: 'Vamos', onPressed: ()=>null,)

      //   );
      // Scaffold.of(context).showSnackBar(snackbar);
    }, onLaunch: (info) {
      print('======= On Launch ========');
      print(info);

      String argumento = 'no-data';

      if (Platform.isAndroid) {
        argumento = info['data']['ayuda'] ?? 'no-data';
      } else {
        argumento = info['ayuda'] ?? 'no-data-ios';
      }
      _mensajesStreamController.sink.add(argumento);
    }, onResume: (info) {
      print('======= On Resume ========');
      print(info);

      String argumento = 'no-data';

      if (Platform.isAndroid) {
        argumento = info['data']['ayuda'] ?? 'no-data';
      } else {
        argumento = info['ayuda'] ?? 'no-data-ios';
      }
      _mensajesStreamController.sink.add(argumento);
    }

    );
  }

  dispose() {
    _mensajesStreamController?.close();
  }
}
