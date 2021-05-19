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
      ..username = json['username'] as String
      ..avatar = json['avatar'] as String
      ..vip = json['vip'] as String
      ..status = json['status'] as String;
  }

  Map<String, dynamic> toJson(User instance) {
    return <String, dynamic>{
      "username": instance.username,
    };
  }
}
