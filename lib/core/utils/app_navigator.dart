import 'package:flutter/material.dart';

class AppNavigator {
  static customNavigator(
      {required context, required screen, required bool finish}) {
    finish
        ?Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => screen,
      ),
          (route) => false,
    )
        :Navigator.push(
        context, MaterialPageRoute(builder: (context) => screen));
  }
}
