import 'package:bloc/bloc.dart';
import 'package:find_and_lost/models/user/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:find_and_lost/blocs/user/user_cubit.dart';
import 'package:find_and_lost/views/home/posts/viewPosts/Posts_view.dart';
import 'package:find_and_lost/views/home/profile/profile.dart';

import '../../views/home/add_post/add_post_view.dart';
import '../../views/home/chats/chats_view.dart';
import '../post/post_cubit.dart';
import 'navigate_state.dart';

class NavigateCubit extends Cubit<NavigateState>
{
  int currentIndex=1;
  Color color=Colors.orangeAccent;
  List<Widget>views=[
     PostsView(),
     AddPostView(),
     Profile(user: UserModel(),),
     ChatsView(),
  ];
  List<String>titles=[
    'Home',
    'Add Post',
    'Profile',
    'Chats',
  ];
  NavigateCubit() : super(NavigateInitialState());
  static NavigateCubit get(context) => BlocProvider.of(context);
  void  ChangeIndex(int index,context)
  {

    currentIndex=index;

    if(currentIndex==0)
    {
      PostCubit.get(context).getLikesPost();
      PostCubit.get(context).getCommentsPost();
      PostCubit.get(context).getPostsData();
    }
    if(currentIndex==3)
    {
     UserCubit.get(context).getAllUsersData();

    }
    emit(NavigateChangeState());
  }


}