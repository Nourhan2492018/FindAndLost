import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:find_and_lost/blocs/post/post_state.dart';
import 'package:find_and_lost/models/post.dart';

import '../../constants/settings.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(PostsInitialState());

  static PostCubit get(context) => BlocProvider.of(context);
  PostModel ?postModel;

  //////
  List<PostModel>posts=[];
  List<int>likes=[];
  Map<String,List<String>>commetMap={};
  List<int>comments=[];
  int index=0;
  void getPostsData(){

    posts=[];
    emit(PostsGetLoadingState());

    FirebaseFirestore.instance.collection('posts')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        PostModel model=PostModel.fromJson(element.data());
        model.postId=element.id;
        posts.add(model);
      });
      //postModel= PostModel.fromJson(value.data()!);
      emit(PostsGetSuccessState(UId));
    })
        .catchError((error){
      print(error.toString());
      emit(PostsGetErrorState(error.toString()));
    });
  }
//// get likes
  void getLikesPost()
  {

//likes=[];
    FirebaseFirestore.instance.collection('posts')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get()
            .then((value){
          likes.add(value.docs.length);
          //postModel!.postId=element.id;
        })
            .catchError((error){});
      });
    })
        .catchError((error){
      print(error.toString());
    });
  }
////
  void getCommentsPost()
  {
    //  comments=[];
    FirebaseFirestore.instance.collection('posts')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        element.reference.collection('comments').get()
            .then((value){
          print('kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk');
          print(element.id);
          print(value.docs.length);
          //  postModel!.postId=element.id;
          comments.add(value.docs.length);
        })
            .catchError((error){});
      });

    })
        .catchError((error){
      print(error.toString());
    });
  }

  /////
  var picker = ImagePicker();
  File ? postImageFile ;
  PostModel ?model;
  Future <void>getpostImage()async
  {
    final pickedFile=await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null)
    {
      postImageFile=File(pickedFile.path);
      emit(UploadImagePostsSuccessState());
    }
    else{
      print('No Image Select Now..');
      emit(UploadImagePostsErrorState());
    }

  }
// remove
  void RemovePostImage()
  {
    postImageFile=null;
    emit(RemoveImagePostSuccessState());
  }
// posts
  void UploasPostImage(String dataTime,String PostsType,String textPost)
  {
    //emit(UploadPostLoadingState());
    FirebaseStorage.instance.ref().
    child('posts/${Uri.file(postImageFile!.path).pathSegments.last}')
        .putFile(postImageFile!)
        .then((value){
      value.ref.getDownloadURL()
          .then((value){
        //emit(UploadPostSuccessState());
        print(value);
        uploadPost(value,dataTime, PostsType, textPost);


      })
          .catchError((error){
        emit(UploadPostErrorState());

      });

    })
        .catchError((error){
      emit(UploadPostErrorState());
    });
  }
// post not has image
  void uploadPost(String postImage,String dataTime,String PostsType,String textPost)
  {
    emit(UploadPostLoadingState());
    model =PostModel(
      uid: UId,
      text: textPost,
      type:PostsType,
      dataTime: dataTime,
      postImage:postImage??'',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model!.toMap())
        .then((value){
      emit(UploadPostSuccessState());
      //uploadPostToUserDoc(models!);
    })
        .catchError((error){
      emit(UploadPostErrorState());

    });
  }
// upload data to user dec

//////like post
  void likePost(String postId)
  {

    FirebaseFirestore.instance
        .collection('posts').doc(postId).collection('likes').doc(UId)
        .set({'like':true})
        .then((value){
      emit(LikePostSuccessState(UId));
    })
        .catchError((error){
      emit(LikePostErrorState(error.toString()));
    });
  }
  // comment
  void CommentsPost(String postId,String comment)
  {
    FirebaseFirestore.instance
        .collection('posts').doc(postId).collection('comments')
        .add({'comment':comment,'UId':UId})
        .then((value){
      print('ssssssssssssssssssssssssssssssssssssssssssss');
      emit(CommentPostSuccessState(UId));
    })
        .catchError((error){
      emit(CommentPostErrorState(error.toString()));
    });
  }
}