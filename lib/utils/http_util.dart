import 'dart:io';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:iris/common/errors.dart';
import 'package:iris/common/global.dart';
import 'package:iris/model/index.dart';

const baseUrl = 'http://127.0.0.1:3333/api';

class HttpUtil {
  static Dio dio = new Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 10000,
      receiveTimeout: 5000,
      responseType: ResponseType.json));
  BaseOptions options;

  static void init() {
    dio.options.headers[HttpHeaders.authorizationHeader] =
        Global.profile.accessToken;
  }

  Future<void> login({String username, String password}) async {
    // 通过泛型 => 会报转义错误 => 默认_JsonMap不能直接用对象接
    var r = await dio
        .post("/login", data: {"username": username, "password": password});
    if (r.statusCode != 200) {
      throw CommonError("登录失败");
    }
    var data = r.data as Map<String, dynamic>;
    var obj = data["data"] as Map<String, dynamic>;
    var accessToken = obj["accessToken"] as String;
    var refreshToken = obj["refreshToken"] as String;
    dio.options.headers[HttpHeaders.authorizationHeader] = accessToken;
    Global.profile.accessToken = accessToken;
    Global.profile.refreshToken = refreshToken;
  }

  Future<void> refreshToken() async {
    var r =
        await dio.post("/token", data: {"token": Global.profile.refreshToken});
    if (r.statusCode != 200) {
      throw CommonError("刷新token失败");
    }
    var data = r.data as Map<String, dynamic>;
    var accessToken = data["data"];
    dio.options.headers[HttpHeaders.authorizationHeader] = accessToken;
    Global.profile.accessToken = accessToken;
  }

  Future<User> getUser() async {
    var r = await dio.get("/user");
    if (r.statusCode != 200) {
      throw CommonError("获取用户信息失败");
    }

    var data = r.data as Map<String, dynamic>;
    var obj = data["data"] as Map<String, dynamic>;
    return User.fromJson(obj);
  }

  Future<List<Section>> getSectionList() async {
    var r = await dio.get("/section");
    if (r.statusCode != 200) {
      throw CommonError("获取section信息失败");
    }
    var data = r.data as Map<String, dynamic>;
    var obj = data["data"] as List<dynamic>;
    return obj
        .map((item) => Section.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<List<Record>> getRecordList(String sid) async {
    var r = await dio.get("/record/$sid");
    if (r.statusCode != 200) {
      throw CommonError("获取record信息失败");
    }
    var data = r.data as Map<String, dynamic>;
    var obj = data["data"] as List<dynamic>;
    return obj
        .map((item) => Record.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
