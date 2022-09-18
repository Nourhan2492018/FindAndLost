import 'package:find_and_lost/src/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:find_and_lost/blocs/navigation/navigate_cubit.dart';
import 'package:find_and_lost/blocs/post/post_cubit.dart';
import '../../blocs/navigation/navigate_state.dart';
import '../../blocs/user/user_cubit.dart';
import 'filters/filter_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NavigateCubit,NavigateState>(
      listener: (context, state) {
        PostCubit.get(context).getLikesPost();
        PostCubit.get(context).getCommentsPost();
        UserCubit.get(context).getAllUsersData();
        //PostCubit.get(context).getPostsData();
      },
      builder: (context,state){
        var cubit=NavigateCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColor.defaultColor,
            elevation: 1.0,
            title :  Image.asset('assets/images/lost-found-banner.png',
              height: 40,
              width: 110,
            ),
            actions: [
              IconButton(onPressed: (){Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FilterView()),);}, icon: Icon(Icons.filter_list,size: 25.0,color: AppColor.secondaryColor,)),
            ],
          ),
          body:cubit.views.elementAt(cubit.currentIndex) ,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.ChangeIndex(index,context);
            },
            selectedItemColor: AppColor.secondaryColor,
            showSelectedLabels: true,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home,color: AppColor.secondaryColor,), label: 'Home', backgroundColor: AppColor.defaultColor,),
              BottomNavigationBarItem(icon: Icon(Icons.add_to_photos_sharp,color: AppColor.secondaryColor,),label: 'Add Post', backgroundColor: AppColor.defaultColor,),
              BottomNavigationBarItem(icon: Icon(Icons.person_pin,color: AppColor.secondaryColor,),label: 'Profile',backgroundColor: AppColor.defaultColor,),
              BottomNavigationBarItem(icon: Icon(Icons.chat,color: AppColor.secondaryColor,),label: 'Chats',backgroundColor: AppColor.defaultColor,),
            ],
          ),
        ) ;
      },
    );
  }
}
