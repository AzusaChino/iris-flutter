class User {
  User();

  String id;
  String username;
  String email;
  String avatar;
  String vip;
  String status;

  factory User.fromJson(Map<String, dynamic> json) {
    return User()
      ..username = json['username']
      ..email = json['email']
      ..avatar = json['avatar']
      ..vip = json['vip']
      ..status = json['status'];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "username": this.username,
      "email": this.email,
      "avatar": this.avatar,
      "vip": this.vip,
      "status": this.status
    };
  }
}
