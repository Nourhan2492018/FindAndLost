import 'package:find_and_lost/blocs/authentication/login/user_login_cubit.dart';
import 'package:find_and_lost/blocs/authentication/register/user_register_cubit.dart';
import 'package:find_and_lost/blocs/chat/chat_cubit.dart';
import 'package:find_and_lost/blocs/map/maps_cubit.dart';
import 'package:find_and_lost/blocs/navigation/navigate_cubit.dart';
import 'package:find_and_lost/blocs/notifications/notification_cubit.dart';
import 'package:find_and_lost/blocs/post/post_cubit.dart';
import 'package:find_and_lost/blocs/user/user_cubit.dart';
import 'package:find_and_lost/repository/maps_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/web_services/places_web_services.dart';

class AppRoot extends StatelessWidget {
  Widget starWidget;

  AppRoot(this.starWidget);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => UserLoginCubit()),
        BlocProvider(create: (BuildContext context) => NavigateCubit()),
        BlocProvider(create: (BuildContext context) => NotificationCubit()),
        BlocProvider(create: (BuildContext context) => PostCubit()..getPostsData()),
        BlocProvider(create: (BuildContext context) => UserCubit()..getUserData()),

        BlocProvider(create: (BuildContext context) => ChatCubit()),

        BlocProvider(create: (BuildContext context) => UserRegisterCubit()),
        BlocProvider<MapsCubit>(
          create: (context) => MapsCubit(MapRepo(PlacesWebServices())),
        ),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: starWidget,
      ),
    );
  }
}
