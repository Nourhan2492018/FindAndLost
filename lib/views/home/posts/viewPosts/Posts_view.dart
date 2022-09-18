
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:find_and_lost/blocs/post/post_cubit.dart';
import 'package:find_and_lost/views/home/posts/viewPosts/post_item.dart';

import '../../../../blocs/post/post_state.dart';
class PostsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostCubit,PostState>(
      listener: (context, state) {

      },
      builder: (context,state){
        //PostCubit.get(context).getLikesPost();
        //PostCubit.get(context).getCommentsPost();
        //PostCubit.get(context).getPostsData();
        return Scaffold(
          body: ConditionalBuilder(
            condition: PostCubit.get(context).posts.length>0,
            builder: (context){

              return Padding(
                padding: const EdgeInsets.all(0.0),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: ListView.separated(itemBuilder:(context,index){
                    //PostCubit.get(context).posts.elementAt(index)
                    return PostItem(index);
                  },
                    itemCount: PostCubit.get(context).posts.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    separatorBuilder: (context,index)=>SizedBox(height: 8,),
                  ),

                ),
              );
            },
            fallback: (context)=> Center(child: CircularProgressIndicator(color: Colors.orangeAccent,)),
          ),
        );
      },
    );
  }
}
/*
Container(
            color: Colors.amber.withOpacity(0.3),
            child: Row(
              children: [
                SizedBox(width: 10,),
                Icon(Icons.info_outline,),
                SizedBox(width:5,),
                Expanded(child: Text('Please Varify Your Email')),

                SizedBox(width: 10,),
                TextButton(onPressed: (){

                  FirebaseAuth.instance.currentUser!.sendEmailVerification()
                      .then((value) {
                    MyToast.getToast(" check Your Email");
                    Navigator.push(context,
                      MaterialPageRoute(
                        builder: (context) => Profile(),
                      ),
                    );
                  })
                      .catchError((error){});

                }, child: Text('send',
                  style: TextStyle(color: Colors.blue),),
                ),
                SizedBox(width: 10,),
              ],
            ),
          ),*/