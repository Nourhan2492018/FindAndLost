import 'package:flutter/material.dart';

class Buttom extends StatelessWidget {
  const Buttom({Key? key,required this.fun, required this.text}) : super(key: key);
  final fun;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: fun,
        child: Text(
          text
        ));
  }
}
