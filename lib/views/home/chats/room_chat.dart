import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:find_and_lost/blocs/user/user_cubit.dart';
import 'package:find_and_lost/blocs/user/user_state.dart';
import '../../../models/user/user_model.dart';

import 'package:find_and_lost/views/home/chats/room.dart';
import 'package:find_and_lost/views/home/home_screen.dart';

import '../../../blocs/chat/chat_cubit.dart';
import '../../../blocs/chat/chat_state.dart';
import '../../../src/app_color.dart';

class ChatRoom extends StatefulWidget {

UserModel ?userModel;

ChatRoom(this.userModel);

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
var textController=TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ChatCubit.get(context).getMassages(widget.userModel!.ID!);
  }
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context){
      return BlocConsumer<ChatCubit,ChatState>(
        listener: (context, state) {

        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0.0,
              elevation: 0.2,
              backgroundColor: AppColor.defaultColor,
              leading: IconButton(icon: Icon(Icons.arrow_back,color: AppColor.secondaryColor,),onPressed: (){Navigator.push(context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              );},),
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 23.0,
                    backgroundImage: NetworkImage('${widget.userModel!.image}'),
                  ),
                  SizedBox(width: 15,),
                  Text('${widget.userModel!.name}',style: TextStyle(color: AppColor.secondaryColor,fontSize:17),),
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column (
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(child: Room(messageStream: ChatCubit.get(context).massesSteam!)),
                  Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: AppColor.defaultColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(width: 30,),
                      Expanded(
                        child: Container(
                          child: TextFormField(
                            maxLines: null,
                            expands: true,
                            controller: textController,
                            cursorColor: AppColor.secondaryColor,
                            cursorHeight: 23,
                            style: TextStyle(
                              color: AppColor.secondaryColor,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Message',
                              hintStyle: TextStyle(
                                color: AppColor.txtShade,
                              ),
                            ),

                          ),
                        ),
                      ),
                      Container(
                        height: 45,
                        child: IconButton(
                            onPressed: (){
                          ChatCubit.get(context).sendMassage(widget.userModel!.ID!,
                              textController.value.text, DateTime.now().toString());
                          textController.text='';
                        },
                            icon: Icon(Icons.send,color: Colors.white,size:25,)),

                      ),
                    ],),
                  ),
                ],
              ),
            )
          );
        },
      );

    });
  }
}
