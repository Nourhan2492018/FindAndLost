class UserModel {
  String? name;
  String? age;
  String? address;
  String? phone;
  String? image;

  String? bio;
  String? email;
  String? password;

  String? ID;
  String? token;
  bool? isEmailVerified;

  UserModel(
      {this.name,
      this.email,
      this.address,
      this.phone,
      this.password,
      this.age,
      this.image =
          'https://thumbs.dreamstime.com/b/bad-hair-day-crazy-young-woman-touching-head-looking-camera-her-funny-brunette-emotionally-reacting-to-news-standing-202075257.jpg',
      this.ID,
      this.isEmailVerified = false,
      this.bio});

  UserModel.fromJson(Map<String, dynamic> json) {
    ID = json['ID'];
    token = json['token'];
    name = json['name'];
    age = json['age'];
    phone = json['phone'];
    image = json['image'];
    address = json['address'];
    password = json['password'];
    bio = json['bio'];
    email = json['email'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'ID': ID,
      'token': token,
      'name': name,
      'phone': phone,
      'age': age,
      'address': address,
      'image': image,
      'email': email,
      'password': password,
      'bio': bio,
      'isEmailVerified': isEmailVerified,
    };
  }
}
