import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:find_and_lost/views/home/chats/receive_massage.dart';
import 'package:find_and_lost/views/home/chats/send_message.dart';

import '../../../constants/settings.dart';

class Room extends StatelessWidget {
  final Stream messageStream;

  Room({required this.messageStream});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: messageStream,
        builder: (context, snapshot){
        if (snapshot.hasData) {
          print(snapshot.data.toString());
          QuerySnapshot querySnapshot= snapshot.data as QuerySnapshot;
          return ListView.separated(
            physics: BouncingScrollPhysics(),
            itemCount: querySnapshot.docs.length ,
              itemBuilder: (context,index){
                if(UId== querySnapshot.docs[index]['sendId'])
                {
                  return SendMessage(querySnapshot.docs[index]['text']);
                }
                return ReceiveMassage(querySnapshot.docs[index]['text']);
              },
              separatorBuilder:(context,index)=>SizedBox(height: 10,)
          );
        }
        else {
          return Center(child: Text('Empty'),);
        }
    });
  }
}
