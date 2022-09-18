import 'package:find_and_lost/components/toast.dart';
import 'package:find_and_lost/services/cache_helper/cache.dart';
import 'package:find_and_lost/services/dio_helper/dio.dart';
import 'package:find_and_lost/src/app_root.dart';
import 'package:find_and_lost/views/authentication/login/login_screen.dart';
import 'package:find_and_lost/views/home/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'constants/settings.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("iiiiiiiiiiii");
  print(message.data.toString());
  MyToast.getToast('firebase Messaging Background Handler');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  var tok = await FirebaseMessaging.instance.getToken();
  print("iiiiiiiiiiii");
  print('token =' + tok.toString());
  token = tok.toString();
  print("==token = " + token);
  FirebaseMessaging.onMessage.listen((event) {
    print("iiiiiiiiiiii");
    print(event.data.toString());
    MyToast.getToast('on Message Opened App');
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print("iiiiiiiiiiii");
    print(event.data.toString());
    MyToast.getToast('on Message Opened App');
  });
  //FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler())
  DioHelper.init();
  await CacheHelper.init();
  print("uuuuuuuuuuuuuiiiiiiiiiiiddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd");
  UId = CacheHelper.getData('UId');
  print(UId);
  Widget widget;
  if (UId != null) {
    widget = HomeScreen();
  } else {
    widget = LoginScreen();
  }
  runApp(AppRoot(widget));
}
