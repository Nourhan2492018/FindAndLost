import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:find_and_lost/blocs/user/user_state.dart';
import 'package:find_and_lost/models/message.dart';
import 'package:find_and_lost/models/post.dart';

import '../../constants/settings.dart';
import '../../models/user/user_model.dart';

class UserCubit extends Cubit<UserState>
{
  UserCubit() : super(UsersGetInitialState());
  static  UserCubit get (context)=> BlocProvider.of(context);
   UserModel ? userModel;

   void getUserData(){

     emit(UserGetLoadingState());
     print("uuuuuuuuuuuuuuiiiiiiiiiiiiiiiiiiddddddddddddddddddddddddddddddddddddddddddddddddddddd");
     print(UId);
     FirebaseFirestore.instance.collection('users').doc(UId).get()
         .then((value) {
       print("ssssssssssssssssuuuuuuuuuuuuccccccssssssssssssssssssssseeeeeeeeeeeeeeeeeeeeeeesssssssss");

       userModel= UserModel.fromJson(value.data()!);
       emit(UserGetSuccessState(UId));
     })
         .catchError((error){
       print(error.toString());
       emit(UserGetErrorState());
     });
   }

  var picker = ImagePicker();
  // Pick an image
  File ? profileImage ;

  Future <void>getProfileImage()async
  {
    final pickedFile=await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null)
    {
      profileImage=File(pickedFile.path);
      emit(UsersGetImageProfileSuccessState());
    }
    else{
      print('No Image Select Now..');
      emit(UsersGetImageProfileErrorState());
    }

  }
  String urlImageProfile='';

  void uploadProfileImage( String name,String age,
      String phone,String pass,String address,String bio)
  {
    emit(UsersUpdateProfileInfoLoadingState());
    FirebaseStorage.instance.ref().
    child('users/${Uri.file(profileImage!.path).pathSegments.last}')
    .putFile(profileImage!)
    .then((value){
      value.ref.getDownloadURL()
          .then((value){
            emit(UsersUploadImageProfileSuccessState());
           print(value);
           upadetaUserData(name, age, phone, pass, address, bio, value);
      })
          .catchError((error){
        emit(UsersUploadImageProfileErrorState());

      });

    })
    .catchError((error){
      emit(UsersUploadImageProfileErrorState());
    });
  }

  void upadetaUserData( String name,String age,
    String phone,String pass,String address,String bio,String image)
{
  UserModel model = UserModel(
    ID: UId,
    name: name,
    age: age,
    address: address,
    phone: phone,
    bio: bio,
    password: pass,
    isEmailVerified: userModel!.isEmailVerified,
    image: image??userModel!.image,
    email: userModel!.email,
  );
  FirebaseFirestore.instance
      .collection('users').doc(UId)
      .update(model.toMap())
      .then((value){

    getUserData();

  })
      .catchError((error){
    emit(UsersUpdateProfileInfoErrorState());
    print('errorrrrrrrrrrrrrrrrrrrrrrrrrrrrrr');
  });
}
////////////////////////////
  List<UserModel>?users;
  void getAllUsersData(){

    users=[];
    emit(GetAllUsersLoadingState());

    FirebaseFirestore.instance.collection('users')
        .get()
        .then((value) {

      value.docs.forEach((element) {

        if(element.data()['ID'] != UId)
          {
            users!.add(UserModel.fromJson(element.data()));
          }
      });
      //postModel= PostModel.fromJson(value.data()!);
      emit(GetAllUsersSuccessState(UId));
    })
        .catchError((error){
      print(error.toString());
      emit(GetAllUsersErrorState());
    });
  }
  // masssages
 /* void sendMassage(String receiverId,String text, String dateTime)
  {
    Massage massage=new Massage(
      senderId: UId,
      receiverId:receiverId,
      dateTime: dateTime,
      text: text,
    );
    // nour chat
    FirebaseFirestore.instance.collection('users')
        .doc(UId).collection('chats').doc(receiverId)
        .collection('massages').doc(dateTime).set(massage.toMap())
        // .add(massage.toMap())
        .then((value){

          emit(SendMassageSuccessState());
    })
        .catchError((error){
      print(error.toString());

      emit(SendMassageErrorState());
    });
    //nourhan chat
    FirebaseFirestore.instance.collection('users')
        .doc(receiverId).collection('chats').doc(UId)
        .collection('massages')//.doc(dateTime).set(massage.toMap())
        .add(massage.toMap())
        .then((value){
      emit(SendMassageSuccessState());
    })
        .catchError((error){
          print(error.toString());
      emit(SendMassageErrorState());
    });
  }
  //
  List<Massage>massages=[];
  Stream ? massesSteam;
  void getMassages(String receiverId)
  {
    massesSteam= FirebaseFirestore.instance.collection('users').doc(UId)
        .collection('chats').doc(receiverId).collection('massages').orderBy('dateTime')
        .snapshots();
    print (massesSteam.toString());
          emit(GetAllMassagesSuccessState());

  }*/
/////////////////////////////////////
///////////////////////////////////////
//poto post
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
      uid: userModel!.ID,
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
      uploadPostToUserDoc(model!);
    })
        .catchError((error){
      emit(UploadPostErrorState());

    });
  }
// upload data to user dec
void uploadPostToUserDoc(PostModel model)
{
  FirebaseFirestore.instance
      .collection('users').doc(UId).collection('userPosts')
      .add(model.toMap())
      .then((value){
emit(UploadPostTOUserDocSuccessState());
  })
      .catchError((error){
    emit(UploadPostTOUserDocErrorState());
  });


}
}