class NotificationBodyModel {
  String? title;
  String? body;
  bool? mutableContent;
  String? sound;

  NotificationBodyModel({this.title, this.body, this.mutableContent, this.sound});

  NotificationBodyModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
    mutableContent = json['mutable_content'];
    sound = json['sound'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['body'] = this.body;
    data['mutable_content'] = this.mutableContent;
    data['sound'] = this.sound;
    return data;
  }
}