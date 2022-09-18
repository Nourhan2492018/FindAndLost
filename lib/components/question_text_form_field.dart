import 'package:find_and_lost/src/app_color.dart';
import 'package:flutter/material.dart';

class QuestionTextFormField extends StatelessWidget {

  QuestionTextFormField({Key? key, required this.text , required this.textController}) : super(key: key);
  final String text;
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      controller: textController,
      cursorColor: Theme.of(context).cursorColor,
      decoration:  InputDecoration(
        hintText: text,
        hintStyle: TextStyle(
          color: AppColor.txtShade,
        ),


      ),
    );
  }
}
