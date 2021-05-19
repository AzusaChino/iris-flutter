import 'package:flutter/material.dart';
import 'package:iris/common/global.dart';
import 'package:iris/provider/profile_change_notifier.dart';

class ThemeModel extends ProfileChangeNotifier {
  ColorSwatch get theme =>
      Global.themes.firstWhere((element) => element.value == profile.theme,
          orElse: () => Colors.blue);

  set theme(ColorSwatch color) {
    if (color != theme) {
      profile.theme = color[500].value;
      notifyListeners();
    }
  }
}
