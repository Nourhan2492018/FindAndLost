import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_and_lost/blocs/authentication/register/user_register_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/toast.dart';
import '../../../constants/settings.dart';
import '../../../models/user/user_model.dart';

class UserRegisterCubit extends Cubit<UserRegisterState> {
  UserRegisterCubit() : super(UserRegisterInitialState());

  static UserRegisterCubit get(context) => BlocProvider.of(context);

  void UserRegister(UserModel user) {
    emit(UserRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: user.email!, password: user.password!)
        .then((value) {
      MyToast.getToast("Register Success");
      user.ID = value.user!.uid;
      UserCreate(user, value.user!.uid);
      //emit(UserRegisterSuccessState());

      //   return true;
    }).catchError((error) {
      emit(UserRegisterErrorState(error.toString()));
      // return false;
    });
  }

  void UserCreate(UserModel user, String UId) {
    user.ID = UId;
    user.token = token;
    FirebaseFirestore.instance
        .collection('users')
        .doc(UId)
        .set(user.toMap())
        .then((value) {
      emit(UserCreateSuccessState());
    }).catchError((error) {
      emit(UserCreateErrorState(error.toString()));
    });
  }
}
