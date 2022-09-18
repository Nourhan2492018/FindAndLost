import 'package:find_and_lost/components/question_item.dart';
import 'package:find_and_lost/src/app_color.dart';
import 'package:flutter/material.dart';


class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({Key? key}) : super(key: key);
  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  List<String> answers = List<String>.filled(4, "Answer", growable: false);


  String questionToPrint = "";
  int indexToPrint = -1;
  @override
  Widget build(BuildContext context) {
    List<String> questions = List<String>.filled(4, "q", growable: false);
    questions[0] ='what is the color of the wallet?';
    questions[1] = 'how much money was inside of it?';
    questions[2] ='what is the color of the wallet?';
    questions[3] = 'how much money was inside of it?';
    return Scaffold(
      backgroundColor: AppColor.secondaryColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: AppColor.defaultColor,
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        padding: EdgeInsets.only(top: 40, left: 25, right: 25, bottom: 25,),
        child: Column(
          children: [
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                indexToPrint = index + 1;
                questionToPrint = '$indexToPrint. '+ questions[index];
                return Container(
                  child: Column(
                    children: [
                      QuestionItem(question: questionToPrint, answers: answers),
                      SizedBox(height: 15,),
                    ],
                  ),
                );
              },
              itemCount: 4,
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: AppColor.defaultColor,
              ),
              child: MaterialButton(
                onPressed: () {
                },
                child: Text(
                    "Submit"),
                textColor: AppColor.secondaryColor,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
