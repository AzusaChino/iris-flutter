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

  Future<bool> login({String username, String password}) async {
    var r = await dio
        .post("/login", data: {"username": username, "password": password});
    if (r.statusCode != 200) {
      throw CommonError("登录失败");
    }

    var obj = r.data.data;
    dio.options.headers[HttpHeaders.authorizationHeader] = obj.accessToken;
    Global.profile.accessToken = obj.accessToken;
    Global.profile.refreshToken = obj.refreshToken;
    return true;
  }

  Future<bool> refreshToken() async {
    var r =
        await dio.post("/token", data: {"token": Global.profile.refreshToken});
    if (r.statusCode != 200) {
      throw CommonError("刷新token失败");
    }
    var obj = r.data.data;
    dio.options.headers[HttpHeaders.authorizationHeader] = obj;
    Global.profile.accessToken = obj;
    return true;
  }

  Future<User> getUser() async {
    var r = await dio.get("/user");
    if (r.statusCode != 200) {
      throw CommonError("获取用户信息失败");
    }
    return User.fromJson(r.data.data);
  }

  Future<List<Section>> getSectionList() async {
    var r = await dio.get("/section");
    return r.data.data.map((e) => Section.fromJson(e)).toList();
  }

  Future<List<Record>> getRecordList(String sid) async {
    var r = await dio.get("/record/$sid");
    return r.data.data.map((e) => Record.fromJson(e)).toList();
  }
}
