import 'package:bloc/bloc.dart';
import 'package:find_and_lost/blocs/authentication/login/user_login_cubit.dart';
import 'package:find_and_lost/blocs/authentication/login/user_login_state.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/toast.dart';
import '../../../models/user/user_model.dart';

class UserLoginCubit extends Cubit<UserLoginState> {
  UserLoginCubit() : super(UserLoginInitialState());
  static UserLoginCubit get(context) => BlocProvider.of(context);

  void Login(UserModel user) {
    emit(UserLoginLoadingState());
    print(user.email);
    print(user.password);
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: user.email!, password: user.password!)
        .then((value) {
      print(";;lllllllllll");
      print(value.user?.uid);
      print(value.user?.email);
      MyToast.getToast("Login Success");
      emit(UserLoginSuccessState(value.user!.uid));
    }).catchError((error) {
      emit(UserLoginErrorState(error.toString()));
    });
  }
}
