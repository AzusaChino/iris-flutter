import 'package:flutter/material.dart';
import 'package:iris/common/global.dart';
import 'package:iris/provider/theme_model.dart';
import 'package:iris/provider/user_model.dart';
import 'package:iris/ui/explore/index.dart';
import 'package:iris/ui/login/index.dart';
import 'package:iris/ui/main/index.dart';
import 'package:iris/ui/mine/index.dart';
import 'package:iris/ui/home/index.dart';
import 'package:provider/provider.dart';

void main() {
  Global.init().then((_) => runApp(App()));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: UserModel()),
        ChangeNotifierProvider.value(value: ThemeModel())
      ],
      child: Consumer<ThemeModel>(
        builder: (context, themeModel, child) {
          return MaterialApp(
            title: 'Iris',
            theme: ThemeData(primarySwatch: themeModel.theme),
            home: HomeRoute(),
            routes: {
              "/login": (ctx) => LoginPage(), // 登录页
              "/main": (ctx) => MainPage(), // 首页
              "/explore": (ctx) => ExplorePage(), // 探索页
              '/mine': (ctx) => MinePage() // 个人主页
            },
          );
        },
      ),
    );
  }
}
