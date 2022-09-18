
abstract class PostState{}


class PostsInitialState extends PostState{}
class PostsGetLoadingState extends PostState {}
class PostsGetSuccessState extends PostState {
  final String UId;
  PostsGetSuccessState(this.UId);
}

class PostsGetErrorState extends PostState {
  final String error;
  PostsGetErrorState(this.error);

}
//////////////////////////////////

class UploadImagePostsSuccessState extends PostState {

}

class UploadImagePostsErrorState extends PostState {}

//RemoveImagePosts
class RemoveImagePostSuccessState extends PostState {

}

//Create Posts

class UploadPostLoadingState extends PostState {

}
class UploadPostSuccessState extends PostState {

}
class UploadPostErrorState extends PostState {}
// upload to user doc
class UploadPostTOUserDocSuccessState extends PostState {

}
class UploadPostTOUserDocErrorState extends PostState {}

//// like post
class LikePostLoadingState extends PostState {}
class LikePostSuccessState extends PostState {
  final String UId;
  LikePostSuccessState(this.UId);
}

class LikePostErrorState extends PostState {
  final String error;
  LikePostErrorState(this.error);
}
//
class CommentPostSuccessState extends PostState {
  final String UId;
  CommentPostSuccessState(this.UId);
}

class CommentPostErrorState extends PostState {
  final String error;
  CommentPostErrorState(this.error);
}