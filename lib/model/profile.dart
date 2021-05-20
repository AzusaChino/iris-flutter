import 'package:iris/model/user.dart';

class Profile {
  Profile();

  User user;
  String accessToken;
  String refreshToken;
  int theme;
  String lastLogin;

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile()
      ..user = User.fromJson(json["user"])
      ..accessToken = json["accessToken"]
      ..refreshToken = json["refreshToken"]
      ..theme = json["theme"]
      ..lastLogin = json["lastLogin"];
  }

  Map<String, dynamic> toJson() {
    return {
      "user": user.toJson(),
      "accessToken": this.accessToken,
      "refreshToken": this.refreshToken,
      "theme": this.theme,
      "lastLogin": this.lastLogin
    };
  }
}
