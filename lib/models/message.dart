class Massage{
  String ? receiverId;
  String ? senderId;
  String ? text;
  String ? dateTime;
  //String ? image;

  Massage(
      {this.receiverId, this.senderId, this.text,
        this.dateTime}
      );

  Massage.fromJson(Map<String ,dynamic> json)
  {
    receiverId=json['receiveId'];
    senderId=json['sendId'] ;
    dateTime=json['dateTime'];
    text=json['text'] ;

  }

  Map<String,dynamic> toMap(){

    return {
      'receiveId':receiverId,
      'sendId':senderId,
      'dateTime':dateTime,
      'text':text,

    };

  }



}