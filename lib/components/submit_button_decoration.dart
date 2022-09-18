import 'package:find_and_lost/src/app_color.dart';
import 'package:flutter/material.dart';

class SubmitButtonDecoration extends StatelessWidget {
  Widget child;

  SubmitButtonDecoration({required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: AppColor.defaultColor,
      ),
      child: child,
    );
  }
}
