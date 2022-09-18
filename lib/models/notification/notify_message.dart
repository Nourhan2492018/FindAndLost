import 'notfication_body.dart';

class NotifyMessageModel {
  String? to;
  bool? directBootOk;
  NotificationBodyModel? notification;


  NotifyMessageModel({this.to, this.directBootOk,this.notification});

  NotifyMessageModel.fromJson(Map<String, dynamic> json) {
    to = json['to'];
    directBootOk = json['directBootOk'];
    notification = json['notification'] != null
        ? new NotificationBodyModel.fromJson(json['notification'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['to'] = this.to;
    data['directBootOk'] = this.directBootOk;
    if (this.notification != null) {
      data['notification'] = this.notification!.toJson();
    }
    return data;
  }
}

