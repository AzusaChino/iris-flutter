import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:iris/common/global.dart';
import 'package:iris/model/index.dart';

const baseUrl = 'http://127.0.0.1:3030/api';

class HttpUtil {
  HttpUtil([this.ctx]) {
    _options = Options(extra: {"context": ctx});
  }

  BuildContext ctx;
  Options _options;

  static Dio dio = new Dio(BaseOptions(baseUrl: baseUrl));

  static void init() {
    // null means not login
    dio.options.headers[HttpHeaders.authorizationHeader] = Global.profile.token;
  }

  Future<User> login({String username, String password}) async {
    String basic = 'Basic ' + base64.encode(utf8.encode('$username:$password'));
    var r = await dio.post("/login",
        data: {"username": username, "password": password},
        options: _options.copyWith(
            headers: {HttpHeaders.authorizationHeader: basic},
            extra: {"noCache": true}));

    dio.options.headers[HttpHeaders.authorizationHeader] = basic;
    Global.profile.token = basic;
    return User.fromJson(r.data.data);
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
