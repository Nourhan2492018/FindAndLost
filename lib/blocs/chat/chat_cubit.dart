import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/settings.dart';
import '../../models/message.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState>
{

  ChatCubit() : super(ChatInitialState());
  static ChatCubit get(context) => BlocProvider.of(context);


  // masssages
  void sendMassage(String receiverId,String text, String dateTime)
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

  }



}