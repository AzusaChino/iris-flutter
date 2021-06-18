import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iris/model/index.dart';
import 'package:iris/utils/http_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _themes = <MaterialColor>[
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.amber,
  Colors.red
];

class Global {
  // 本地存储
  static SharedPreferences _prefs;
  // current user profile
  static Profile profile = Profile();
  // theme list
  static List<MaterialColor> get themes => _themes;

  // 是否为Product环境
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  static Future init() async {
    // 解决android环境下的报错问题
    // ignore: invalid_use_of_visible_for_testing_member
    SharedPreferences.setMockInitialValues({});
    _prefs = await SharedPreferences.getInstance();
    var _profile = _prefs.getString("profile");
    if (_profile != null) {
      try {
        profile = Profile.fromJson(jsonDecode(_profile));
      } catch (e) {
        print("系统初始化时发生了错误, $e");
      }
    }
    HttpUtil.init();
  }

  static saveProfile() =>
      _prefs.setString("profile", jsonEncode(profile.toJson()));
}
