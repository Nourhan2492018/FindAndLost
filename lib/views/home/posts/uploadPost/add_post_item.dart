import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:find_and_lost/blocs/post/post_cubit.dart';
import '../../../../blocs/post/post_state.dart';
import '../../../../blocs/post/post_state.dart';

class AddPostItem extends StatelessWidget {

  var textController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostCubit,PostState>(
      listener: (context, state) {
        if(PostCubit.get(context).postImageFile==null)
       {
         PostCubit.get(context).uploadPost('',DateTime.now().toString(), 'found', textController.value.text);
       }
       else
       {
         PostCubit.get(context).UploasPostImage(DateTime.now().toString(),'found' ,textController.value.text);
        }
      },
      builder: (context,state){
        return Column(children: [
          TextFormField(
            controller: textController,
            decoration: InputDecoration(
              hintText: 'what is on your mind...... ?',
              border: InputBorder.none,
            ),
          ),
          if(PostCubit.get(context).postImageFile!=null)
            Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              Container(
                height:250.0 ,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  image:DecorationImage(
                    //
                      image:Image.file(PostCubit.get(context).postImageFile!).image,
                      fit: BoxFit.cover),

                ),

              ),
              IconButton(onPressed: (){
                PostCubit.get(context).RemovePostImage();
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
                 PostCubit.get(context).getpostImage();
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
        ],);
      },
    );
  }
}
