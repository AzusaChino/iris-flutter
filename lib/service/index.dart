import 'dart:io';

import 'package:iris/common/errors.dart';
import 'package:iris/common/global.dart';
import 'package:iris/model/index.dart';
import 'package:iris/utils/http_util.dart';

Future<bool> register({String username, String email, String password}) async {
  var r = await HttpUtil.dio.post("/register",
      data: {"username": username, "email": email, "password": password});
  if (r.statusCode != 200) {
    throw CommonError("注册失败");
  }
  return true;
}

Future<void> login({String username, String password}) async {
  // 通过泛型 => 会报转义错误 => 默认_JsonMap不能直接用对象接
  var r = await HttpUtil.dio
      .post("/login", data: {"username": username, "password": password});
  if (r.statusCode != 200) {
    throw CommonError("登录失败");
  }
  var data = r.data as Map<String, dynamic>;
  var obj = data["data"] as Map<String, dynamic>;
  var accessToken = obj["accessToken"] as String;
  var refreshToken = obj["refreshToken"] as String;
  HttpUtil.dio.options.headers[HttpHeaders.authorizationHeader] = accessToken;
  Global.profile.accessToken = accessToken;
  Global.profile.refreshToken = refreshToken;
}

Future<void> refreshToken() async {
  var r = await HttpUtil.dio
      .post("/token", data: {"token": Global.profile.refreshToken});
  if (r.statusCode != 200) {
    throw CommonError("刷新token失败");
  }
  var data = r.data as Map<String, dynamic>;
  var accessToken = data["data"];
  HttpUtil.dio.options.headers[HttpHeaders.authorizationHeader] = accessToken;
  Global.profile.accessToken = accessToken;
}

Future<User> getUser() async {
  var r = await HttpUtil.dio.get("/user");
  if (r.statusCode != 200) {
    throw CommonError("获取用户信息失败");
  }

  var data = r.data as Map<String, dynamic>;
  var obj = data["data"] as Map<String, dynamic>;
  return User.fromJson(obj);
}
