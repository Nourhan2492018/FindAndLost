import 'package:flutter/material.dart';
import '../../../models/user/user_model.dart';
import 'package:find_and_lost/views/home/chats/room_chat.dart';

class ChatItem extends StatelessWidget {
UserModel ?model;

ChatItem(this.model);

  @override

  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context,
          MaterialPageRoute(
            builder: (context) => ChatRoom(model),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 1.0,
            color: Colors.blue[100],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [

                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage('${model!.image}'),
                ),
                SizedBox(width:20,),
                Expanded(child:Text('${model!.name}',
                  style: TextStyle(height:1.4,color: Colors.black),),),
              ],
            ),
          ),
        ],

      ),
    );
  }
}
