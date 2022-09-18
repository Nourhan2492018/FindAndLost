import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:find_and_lost/blocs/user/user_cubit.dart';
import 'package:find_and_lost/blocs/user/user_state.dart';
import 'package:find_and_lost/views/home/home_screen.dart';
import 'package:find_and_lost/views/home/profile/profile.dart';

class CreatePost extends StatelessWidget {

  var textController=TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit,UserState>(
      listener: (context, state) {
        if(state is UploadPostSuccessState)
          {
            Navigator.push(context,
              MaterialPageRoute(
                builder: (context) => Profile(user: UserCubit.get(context).userModel!),
              ),
            );
          }
      },
      builder: (context,state){
       return Scaffold(
         appBar:AppBar(backgroundColor: Colors.white,
           elevation: 0,
           titleSpacing: 0.0,
           leading: IconButton(icon: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.black,)
           ,onPressed: (){
             Navigator.push(context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              );
             },),
           actions: [
             Padding(
               padding: const EdgeInsets.only(right:15),
               child: TextButton(onPressed: (){
                 // UsersInfoCubit.get(context).getUserData();
                 if(UserCubit.get(context).postImageFile==null)
                   {

                     UserCubit.get(context).uploadPost('',DateTime.now().toString(), 'lost', textController.value.text);
                   }
                 else
                   {
                     UserCubit.get(context).UploasPostImage(DateTime.now().toString(),'lost' ,textController.value.text);
                   }


               }
                   , child: Text('POST')),
             )],
           title:  Text('Create Post',
             style: TextStyle(color: Colors.black),),),
         body: ConditionalBuilder(
           condition:state is! UserGetLoadingState ,
           builder: (context){
             return Container(
               color: Colors.white,
               child: Padding(
                 padding: const EdgeInsets.all(20.0),
                 child:SingleChildScrollView(child:  Column(
                   children: [
                     if(state is UploadPostLoadingState)
                       LinearProgressIndicator(),
                     if(state is UploadPostLoadingState)
                       SizedBox(height: 5,),
                     Row(
                       children: [
                         CircleAvatar(
                           radius: 30,
                           backgroundImage: NetworkImage('${UserCubit.get(context).userModel!.image!}'),
                         ),
                         SizedBox(width:15,),
                         Expanded(child:Text('${UserCubit.get(context).userModel!.name!}',
                           style: TextStyle(height:1.4,color: Colors.black),),),

                       ],
                     ),
                     TextFormField(
                       controller: textController,
                       decoration: InputDecoration(
                         hintText: 'what is on your mind...... ?',
                         border: InputBorder.none,
                       ),
                     ),
                     if(UserCubit.get(context).postImageFile!=null)
                       Stack(
                         alignment: AlignmentDirectional.topEnd,
                         children: [
                           Container(
                             height:250.0 ,
                             width: double.infinity,
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(4.0),
                               image:DecorationImage(
                                   image:Image.file(UserCubit.get(context).postImageFile!).image,
                                   fit: BoxFit.cover),

                             ),

                           ),
                           IconButton(onPressed: (){

                             UserCubit.get(context).RemovePostImage();
                           },
                             icon: CircleAvatar(
                               backgroundColor:Colors.redAccent ,
                               radius:10,
                               child: Icon(Icons.close,size:13,)
                               ,),
                           ),
                         ],
                       ),
                     SizedBox(height:25,),
                     Row(
                       children: [
                         Expanded(child:TextButton(onPressed: (){
                           UserCubit.get(context).getpostImage();
                         }, child: Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Icon(Icons.image),
                             SizedBox(width:5,),
                             Text('Add Pohto'),

                           ],
                         ),),),
                         Expanded(child:TextButton(onPressed: (){}, child: Text('#Type'),),),

                       ],
                     ),
                   ],
                 ),),
               ),
             );
           },
           fallback:(context)=> Center(child: CircularProgressIndicator(color: Colors.orangeAccent,)) ,
         ),
       );
      },
    );
  }
}
