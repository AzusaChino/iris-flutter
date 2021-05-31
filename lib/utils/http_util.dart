import 'dart:io';

import 'package:dio/dio.dart';
import 'package:iris/common/global.dart';

// 手机环境下，有自己的一套网络环境，不能直接使用localhost
const baseUrl = 'http://192.168.0.104:3333/api';
// const baseUrl = 'http://localhost:3333/api';

class HttpUtil {
  static Dio dio = new Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 10000,
      receiveTimeout: 5000,
      responseType: ResponseType.json));

  static void init() {
    dio.options.headers[HttpHeaders.authorizationHeader] =
        Global.profile.accessToken;
  }
}
