import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:find_and_lost/blocs/user/user_cubit.dart';
import 'package:find_and_lost/views/home/chats/chat_item.dart';

import '../../../blocs/user/user_state.dart';

class ChatsView extends StatefulWidget {

  @override
  State<ChatsView> createState() => _ChatsViewState();
}

class _ChatsViewState extends State<ChatsView> {

  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit,UserState>
      (listener: (context, state) {

      },
    builder: (context,state){
        return Scaffold(
          body: ConditionalBuilder(
            condition:UserCubit.get(context).users!.length>0,
            builder: (context){
              return Container(
                color: Colors.white,
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder:(context,index){
                    return  ChatItem(
                       UserCubit.get(context).users!.elementAt(index));
                       },
                  separatorBuilder: (context,index)=>SizedBox(height: 8,),
                  //SocialInfoCubit.get(context).users!.length,
                  itemCount: UserCubit.get(context).users!.length,
                ),
              );
            },
            fallback:  (context)=> Center(child: CircularProgressIndicator(color: Colors.orangeAccent,)),
          ),
        );
    },);
  }
}
