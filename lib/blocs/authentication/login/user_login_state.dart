abstract class UserLoginState {}

class UserLoginInitialState extends UserLoginState {}

class UserLoginLoadingState extends UserLoginState {}

class UserLoginSuccessState extends UserLoginState {
  final String UId;
  UserLoginSuccessState(this.UId);
}

class UserLoginErrorState extends UserLoginState {
  final String error;
  UserLoginErrorState(this.error);
}
