import 'dart:ui';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:find_and_lost/models/user/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:find_and_lost/blocs/user/user_cubit.dart';
import 'package:find_and_lost/blocs/user/user_state.dart';
import 'package:find_and_lost/views/home/posts/uploadPost/create_post.dart';
import 'package:find_and_lost/views/home/profile/edit_profile.dart';

class Profile extends StatelessWidget {
  UserModel user;
  Profile({required UserModel this.user});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit,UserState>(
      listener: (context,state){},
      builder: (context,state){
        // TODO: EDITED
        var userModel=user.ID == null? UserCubit.get(context).userModel : user;
        return Scaffold(
          body: ConditionalBuilder(
            condition: state is! UserGetLoadingState && userModel?.ID != null,
            builder: (context){
             return Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(children: [
                  Container(
                    height: 220,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,

                          child: Container(
                            height:170.0 ,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft:  Radius.circular(4.0),
                                topRight:  Radius.circular(4.0),
                              ),
                              image:DecorationImage(
                                  image: NetworkImage('https://thumbs.dreamstime.com/b/bad-hair-day-crazy-young-woman-touching-head-looking-camera-her-funny-brunette-emotionally-reacting-to-news-standing-202075257.jpg') ,
                                  fit: BoxFit.cover),

                            ),

                          ),
                        ),
                        CircleAvatar(
                          radius: 65,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(radius: 60.0,
                            backgroundImage:  NetworkImage('${userModel!.image}'),),
                        ),
                      ],
                    ),
                  ),
                  Text('${userModel!.name}',style:TextStyle(color: Colors.black,fontStyle: FontStyle.italic),),
                  Text('${userModel!.bio}',style:TextStyle(color: Colors.grey,fontStyle: FontStyle.italic),),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20,),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(

                            child: Column(children: [
                              Text('100',style:TextStyle(color: Colors.black,fontStyle: FontStyle.normal,fontSize: 25,),),
                              Text('posts',style:TextStyle(color: Colors.grey,fontStyle: FontStyle.normal,fontSize: 15,),),
                            ],),
                            onTap: (){},
                          ),
                        ),
                        Expanded(
                          child: InkWell(

                            child: Column(children: [
                              Text('14',style:TextStyle(color: Colors.black,fontStyle: FontStyle.normal,fontSize: 25,),),
                              Text('Lost',style:TextStyle(color: Colors.grey,fontStyle: FontStyle.normal,fontSize: 15,),),
                            ],),
                            onTap: (){},
                          ),
                        ),
                        Expanded(
                          child: InkWell(

                            child: Column(children: [
                              Text('100',style:TextStyle(color: Colors.black,fontStyle: FontStyle.normal,fontSize: 25,),),
                              Text('Views',style:TextStyle(color: Colors.grey,fontStyle: FontStyle.normal,fontSize: 15,),),
                            ],),
                            onTap: (){},
                          ),
                        ),
                        Expanded(
                          child: InkWell(

                            child: Column(children: [
                              Text('80',style:TextStyle(color: Colors.black,fontStyle: FontStyle.normal,fontSize: 25,),),
                              Text('share',style:TextStyle(color: Colors.grey,fontStyle: FontStyle.normal,fontSize: 15,),),
                            ],),
                            onTap: (){},
                          ),
                        ),
                      ],
                    ),
                  ),
                  user.ID == null ? Row(children: [
                    Expanded(
                      child: OutlinedButton(onPressed: (){
                        Navigator.push(context,
                          MaterialPageRoute(
                            builder: (context) => CreatePost(),
                          ),
                        );
                      },
                        child: Text('Add New Post'),),
                    ),
                    SizedBox(width:6,),
                    OutlinedButton(onPressed: (){
                      Navigator.push(context,
                        MaterialPageRoute(
                          builder: (context) => EditProfile(),
                        ),
                      );
                    },
                      child:Icon(Icons.edit),),
                  ],) : Container(),
                ],),
              );
            },
            fallback: (context)=> Center(child: CircularProgressIndicator(color: Colors.orangeAccent,)),
          ),
        );
      },
    );
  }
}
