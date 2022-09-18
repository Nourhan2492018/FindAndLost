import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class MyToast extends Fluttertoast {

  static getToast(String mass)
  {
    return Fluttertoast.showToast(
      msg: mass,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
