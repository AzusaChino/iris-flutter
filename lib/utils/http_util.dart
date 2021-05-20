import 'dart:io';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:iris/common/common.dart';
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
    // 通过泛型，固定返回值类型
    var r = await dio.post<RestResponse<Map<String, dynamic>>>("/login",
        data: {"username": username, "password": password});
    if (r.statusCode != 200) {
      throw CommonError("登录失败");
    }

    var data = r.data.data;
    var accessToken = data["accessToken"] as String;
    var refreshToken = data["refreshToken"] as String;
    dio.options.headers[HttpHeaders.authorizationHeader] = accessToken;
    Global.profile.accessToken = accessToken;
    Global.profile.refreshToken = refreshToken;
    return true;
  }

  Future<bool> refreshToken() async {
    var r = await dio.post<RestResponse<Map<String, String>>>("/token",
        data: {"token": Global.profile.refreshToken});
    if (r.statusCode != 200) {
      throw CommonError("刷新token失败");
    }
    var data = r.data.data;
    var accessToken = data["accessToken"];
    dio.options.headers[HttpHeaders.authorizationHeader] = accessToken;
    Global.profile.accessToken = accessToken;
    return true;
  }

  Future<User> getUser() async {
    var r = await dio.get<RestResponse<User>>("/user");
    if (r.statusCode != 200) {
      throw CommonError("获取用户信息失败");
    }
    return r.data.data;
  }

  Future<List<Section>> getSectionList() async {
    var r = await dio.get<RestResponse<List<Section>>>("/section");
    return r.data.data;
  }

  Future<List<Record>> getRecordList(String sid) async {
    var r = await dio.get<RestResponse<List<Record>>>("/record/$sid");
    return r.data.data;
  }
}
