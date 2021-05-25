import 'dart:io';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:iris/common/errors.dart';
import 'package:iris/common/global.dart';
import 'package:iris/model/index.dart';

// 手机环境下，有自己的一套网络环境，不能直接使用localhost
// const baseUrl = 'http://10.3.23.16:3333/api';
const baseUrl = 'http://localhost:3333/api';

class HttpUtil {
  static Dio dio = new Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 10000,
      receiveTimeout: 5000,
      responseType: ResponseType.json));
  Options _options;

  static void init() {
    dio.options.headers[HttpHeaders.authorizationHeader] =
        Global.profile.accessToken;
  }

  Future<bool> register(
      {String username, String email, String password}) async {
    var r = await dio.post("/register",
        data: {"username": username, "email": email, "password": password});
    if (r.statusCode != 200) {
      throw CommonError("注册失败");
    }
    return true;
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

  Future<List<Record>> getRecordList(
      {String sid, Map<String, dynamic> params, refresh = false}) async {
    if (refresh) {
      _options.extra.addAll({"refresh": true, "list": true});
    }
    var r = await dio.get("/$sid/record",
        queryParameters: params, options: _options);

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

Future<List<Record>> searchRecordList() async {
  return null;
}
