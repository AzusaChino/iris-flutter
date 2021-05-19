import 'package:flutter/material.dart';
import 'package:iris/common/global.dart';
import 'package:iris/model/index.dart';

class ProfileChangeNotifier extends ChangeNotifier {
  Profile get profile => Global.profile;

  @override
  void notifyListeners() {
    Global.saveProfile();
    super.notifyListeners();
  }
}
