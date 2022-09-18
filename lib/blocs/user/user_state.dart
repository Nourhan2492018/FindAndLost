abstract class UserState {}
class UsersGetInitialState extends UserState {}
class UserGetLoadingState extends UserState {}
class UserGetSuccessState extends UserState {
  final String UId;
  UserGetSuccessState(this.UId);
}

class UserGetErrorState extends UserState {

}

class UsersGetImageProfileSuccessState extends UserState {

}

class UsersGetImageProfileErrorState extends UserState {}

class UsersUploadImageProfileSuccessState extends UserState {

}

class UsersUploadImageProfileErrorState extends UserState {}


class UsersUpdateProfileInfoLoadingState extends UserState {

}
class UsersUpdateProfileInfoSuccessState extends UserState {

}

class UsersUpdateProfileInfoErrorState extends UserState {}
//////////// user list

class GetAllUsersLoadingState extends UserState {}
class GetAllUsersSuccessState extends UserState {
  final String UId;
  GetAllUsersSuccessState(this.UId);
}
class GetAllUsersErrorState extends UserState {

}
////send massages
class SendMassageSuccessState extends UserState {}
class SendMassageErrorState extends UserState {}
////get All Massages massages
class GetAllMassagesSuccessState extends UserState {}
class GetAllMassagesErrorState extends UserState {}

//UploadImagePosts
class UploadImagePostsSuccessState extends UserState {

}

class UploadImagePostsErrorState extends UserState {}

//RemoveImagePosts
class RemoveImagePostSuccessState extends UserState {

}

//Create Posts

class UploadPostLoadingState extends UserState {

}
class UploadPostSuccessState extends UserState {

}
class UploadPostErrorState extends UserState {}
// upload to user doc
class UploadPostTOUserDocSuccessState extends UserState {

}
class UploadPostTOUserDocErrorState extends UserState {}

