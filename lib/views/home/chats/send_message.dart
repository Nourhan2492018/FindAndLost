import 'package:flutter/material.dart';
import 'package:find_and_lost/models/message.dart';

class SendMessage extends StatelessWidget {

String ?massage;

SendMessage(this.massage);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadiusDirectional.only(
            bottomStart: Radius.circular(10),
            topEnd: Radius.circular(10),
            topStart: Radius.circular(10),

          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10,vertical:5),
        child: Text('${massage!}'),
      ),
    );
  }
}
