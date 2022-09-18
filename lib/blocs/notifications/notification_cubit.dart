import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:find_and_lost/models/notification/notify_message.dart';

import '../../constants/settings.dart';
import '../../models/notification/notfication_body.dart';
import '../../services/dio_helper/dio.dart';
import 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState>
{

  NotificationCubit() : super(NotificationInitialState());
  static NotificationCubit get(context) => BlocProvider.of(context);

  void notifyToAllUsers( { required String typePost , required String typeItem}){

    NotificationBodyModel notificationBody=NotificationBodyModel(
      title: typePost,
      body: typeItem,
      mutableContent:true,
      sound: 'Tri-tone'
    );
   print(token);
    NotifyMessageModel data=NotifyMessageModel(to: token,directBootOk: true,notification:notificationBody);
    emit(SendNotificationMassageLoadingState());
    try {
      DioHelper.postNotification(url:'https://fcm.googleapis.com/fcm/send', data:data.toJson()).then((value) {
        //var jsonData=jsonDecode(value.data);
        //registerHub = AuthenticationHub.fromJson(jsonData);
        emit(SendNotificationMassageSuccessState());
        print('dataaaaaaaaaaa= '+value.data.toString());
      }).catchError((error){
        emit(SendNotificationMassageErrorState());
        print(error.toString());
      });
    }
    catch (SocketConnection){
      emit(SendNotificationMassageErrorState());
    }
  }
  // masssages


}