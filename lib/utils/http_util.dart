import 'dart:io';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:iris/common/errors.dart';
import 'package:iris/common/global.dart';
import 'package:iris/model/index.dart';

const baseUrl = 'http://127.0.0.1:3030/api';

class HttpUtil {
  static HttpUtil instance;

  Dio dio;
  BaseOptions options;

  static HttpUtil getInstance() {
    if (null == instance) {
      instance = new HttpUtil();
    }
    return instance;
  }

  HttpUtil() {
    options = new BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: 10000,
        receiveTimeout: 5000,
        responseType: ResponseType.json);
    dio = new Dio(options);

    dio.options.headers[HttpHeaders.authorizationHeader] =
        Global.profile.accessToken;
  }

  Future<bool> login({String username, String password}) async {
    var r = await dio
        .post("/login", data: {"username": username, "password": password});
    if (r.statusCode != 200) {
      return false;
    }

    var data = r.data;
    dio.options.headers[HttpHeaders.authorizationHeader] = data.accessToken;
    Global.profile.accessToken = data.accessToken;
    Global.profile.refreshToken = data.refreshToken;
    return true;
  }

  Future<bool> refreshToken() async {
    var r =
        await dio.post("/token", data: {"token": Global.profile.refreshToken});
    if (r.statusCode != 200) {
      return false;
    }
    var data = r.data;
    dio.options.headers[HttpHeaders.authorizationHeader] = data;
    Global.profile.accessToken = data;
    return true;
  }

  Future<User> getUser() async {
    var r = await dio.get("/user");
    if (r.statusCode != 200) {
      throw CommonError("获取用户信息失败");
    }
    return User.fromJson(r.data);
  }

  Future<List<Section>> getSectionList() async {
    var r = await dio.get("/section");
    return r.data.map((e) => Section.fromJson(e)).toList();
  }

  Future<List<Record>> getRecordList(String sid) async {
    var r = await dio.get("/record/$sid");
    return r.data.map((e) => Record.fromJson(e)).toList();
  }
}
