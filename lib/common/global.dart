import 'package:flutter/material.dart';
import 'package:iris/model/index.dart';

const _themes = <MaterialColor>[
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.amber,
  Colors.red
];

class Global {
  // current user profile
  static Profile profile = Profile();
  // theme list
  static List<MaterialColor> get themes => _themes;

  static Future init() async {

  }

  static void saveProfile() {

  }
}
