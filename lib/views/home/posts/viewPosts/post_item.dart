import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:find_and_lost/views/home/posts/viewPosts/questions_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:find_and_lost/blocs/post/post_cubit.dart';
import 'package:find_and_lost/blocs/user/user_cubit.dart';
import 'package:find_and_lost/blocs/user/user_state.dart';
import 'package:find_and_lost/views/home/profile/profile.dart';

class PostItem extends StatelessWidget {

  var textController=TextEditingController();
int ?index;
PostItem(this.index);

  @override
  Widget build(BuildContext context) {
    var postUserName = UserCubit.get(context).users!.firstWhere((element) => element.ID ==
        PostCubit.get(context).posts.elementAt(index!).uid);
    return BlocConsumer<UserCubit,UserState>(
      listener: (context, state) {
      },
      builder: (context,state){

        return ConditionalBuilder
          (condition:state is! UserGetLoadingState && UserCubit.get(context).users!.length>0,
            builder: (context){
              return Card(
                elevation: 10,
                margin: EdgeInsets.symmetric(horizontal: 10,),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 25,
                            //'https://qph.cf2.quoracdn.net/main-qimg-7bf0d6e2244ba27c49415f9cd55cd65d-lq'
                            backgroundImage: NetworkImage('${postUserName.image}'),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                Text('${postUserName.name}',
                                  style: TextStyle(height:1.4,color: Colors.black),),
                                Icon(Icons.check_circle,color:Colors.blue,size: 15,),
                              ],),
                              Text('${PostCubit.get(context).posts.elementAt(index!).dataTime}',
                                style: TextStyle(height:1.4,color: Colors.grey,fontSize: 10,),),
                            ],),
                        ),
                        SizedBox(width: 10,),
                        IconButton(onPressed: (){
                          Navigator.push(context,
                            MaterialPageRoute(
                              // TODO: Done
                              builder: (context) => Profile(user : postUserName),
                            ),
                          );
                        }, icon:Icon(Icons.more_horiz,color: Colors.grey),),

                      ],),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        height: 1.0,
                        color: Colors.grey[300],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          width: 80,
                          height: 25,
                          decoration: BoxDecoration(
                            color: Colors.deepPurple[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text('${PostCubit.get(context).posts.elementAt(index!).type}',
                              style: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.white
                              ) ,
                            ),
                          ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('${PostCubit.get(context).posts.elementAt(index!).text}'),
                    ),
                    if(PostCubit.get(context).posts.elementAt(index!).postImage!='')
                      Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 150.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image:DecorationImage(
                            //'https://cdn.fs.teachablecdn.com/eNaCbKy3S1iBBLz7aGq4'
                            image: NetworkImage('${PostCubit.get(context).posts.elementAt(index!).postImage}'),
                            fit:BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    if (PostCubit.get(context).posts.elementAt(index!).type=='lost')
                       Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          Container(
                            width: 320.0,
                            height: 40.0,
                            decoration: BoxDecoration(
                              color: Colors.blue[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: TextButton.icon(
                                icon: Icon(Icons.search,
                                  color: Colors.white,
                                  size: 25.0,
                                ),
                                label: Text('I Found It !',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () {},
                              ),
                            ),
                          )
                      ),
                    if (PostCubit.get(context).posts.elementAt(index!).type=='found')
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                          Container(
                            width: 320.0,
                            height: 40.0,
                            decoration: BoxDecoration(
                              color: Colors.blue[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: TextButton.icon(
                                icon: Icon(Icons.shopping_bag_outlined,
                                  color: Colors.white,
                                  size: 25.0,
                                ),
                                label: Text('It\'s Mine !',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => QuestionsScreen()),);
                                },
                              ),
                            ),
                          )
                      ),

                    Padding(
                      padding: const EdgeInsets.only(bottom:6.0),
                      child: Container(
                        width: double.infinity,
                        height: 1.0,
                        color: Colors.grey[300],
                      ),
                    ),

                      ],
                    ),
              );
            }, fallback:(context)=> Center(child: CircularProgressIndicator(color: Colors.orangeAccent,)) );
      },
    );
  }
}
