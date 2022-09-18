import 'package:find_and_lost/src/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum Answers {non, answer1, answer2, answer3, answer4}
class QuestionItem extends StatefulWidget {
  List<String>? answers;
  String question;
  QuestionItem({required this. question, required this. answers});
  @override
  State<QuestionItem> createState() => _QuestionItemState();
}
class _QuestionItemState extends State<QuestionItem> {
  Answers selectedAnswer = Answers.non;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: AppColor.questionsShade,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Text(
              widget.question,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            title: Text(
              widget.answers![0],
            ),
            leading: Radio(
              value: Answers.answer1,
              groupValue: selectedAnswer,
              onChanged: (val) {
                setState(() {
                  selectedAnswer = (val) as Answers;
                });
              },
            ),
          ),
          ListTile(
            title: Text(
              widget.answers![1],
            ),
            leading: Radio(
              value: Answers.answer2,
              groupValue: selectedAnswer,
              onChanged: (val) {
                setState(() {
                  selectedAnswer = (val) as Answers;
                });
              },
            ),
          ),
          ListTile(
            title: Text(
              widget.answers![2],
            ),
            leading: Radio(
              value: Answers.answer3,
              groupValue: selectedAnswer,
              onChanged: (val) {
                setState(() {
                  selectedAnswer = (val) as Answers;
                });
              },
            ),
          ),
          ListTile(
            title: Text(
              widget.answers![2],
            ),
            leading: Radio(
              value: Answers.answer4,
              groupValue: selectedAnswer,
              onChanged: (val) {
                setState(() {
                  selectedAnswer = (val) as Answers;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
