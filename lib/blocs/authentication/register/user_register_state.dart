abstract class UserRegisterState {}

class UserRegisterInitialState extends UserRegisterState {}

class UserRegisterLoadingState extends UserRegisterState {
}

class UserRegisterSuccessState extends UserRegisterState {}

class UserRegisterErrorState extends UserRegisterState {

  final String error;
  UserRegisterErrorState(this.error);

}

///
class UserCreateSuccessState extends UserRegisterState {}

class UserCreateErrorState extends UserRegisterState {

  final String error;
  UserCreateErrorState(this.error);

}
