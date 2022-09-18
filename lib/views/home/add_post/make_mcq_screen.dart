import 'package:flutter/material.dart';

import '../../../components/buttom.dart';
import '../../../components/question_text_form_field.dart';
import '../../../src/app_color.dart';

class MakeMcqScreen extends StatelessWidget {
  MakeMcqScreen({Key? key}) : super(key: key);
  var questionText= TextEditingController();
  var answer1Text= TextEditingController();
  var answer2Text= TextEditingController();
  var answer3Text= TextEditingController();
  var answer4Text= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: AppColor.defaultColor,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.85,
            height: MediaQuery.of(context).size.height * 0.84,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children:  [
                const SizedBox(
                  height: 50,
                ),
                const Center(
                  child: Text(
                    "Quiz",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  //flex: 5,
                  child: Column(
                    children: [
                      QuestionTextFormField(textController: questionText, text: 'Question',),
                      SizedBox(height: 20,),
                      QuestionTextFormField(textController: answer1Text, text: 'Answer 1 (correct answer)',),
                      SizedBox(height: 20,),
                      QuestionTextFormField(textController: answer2Text, text: 'Answer 2',),
                      SizedBox(height: 20,),
                      QuestionTextFormField(textController: answer3Text, text: 'Answer 3 ',),
                      SizedBox(height: 20,),
                      QuestionTextFormField(textController: answer4Text, text: 'Answer 4 ',),
                    ],
                  ),
                ),

                Expanded(
                  //flex: 1,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: AppColor.defaultColor,
                        ),
                        child: MaterialButton(
                          onPressed: (){},
                          child: Text(
                              'Submit',
                            style: TextStyle(
                              color: AppColor.secondaryColor,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: AppColor.defaultColor,
                        ),
                        child: MaterialButton(
                          onPressed: (){},
                          child: Text(
                            'Add Question',
                            style: TextStyle(
                              color: AppColor.secondaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],

            ),
          ),
        ),
      ),
    );
  }
}
