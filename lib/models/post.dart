class PostModel{

  String ? uid;
  //String ? userImage;
  String ? postId;

  String ? dataTime;
  String ? text;
  String ? type;
  String ? postImage;

  PostModel(
      {this.text,
        this.type,
        this.postImage,
        this.dataTime,
        this.uid,
      //  this.userName,
       // this.userImage,
       }
      );

  PostModel.fromJson(Map<String ,dynamic> json)
  {

    text=json['text'] ;
    postImage=json['postImage'] ;
    type=json['type'];
    dataTime=json['dataTime'];
    uid=json['uid'];
    //userName=json['userName'];
    //userImage=json['userImage'];
  }

  Map<String,dynamic> toMap(){

    return {
      'text':text,
      'dataTime':dataTime,
      'type':type,
      'postImage':postImage,
      'uid':uid,
     // 'userImage':userImage,
      //'userName':userName,
    };

  }



}