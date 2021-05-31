import 'package:flutter/material.dart';
import 'package:iris/common/global.dart';
import 'package:iris/provider/theme_model.dart';
import 'package:iris/provider/user_model.dart';
import 'package:iris/ui/auth/login.dart';
import 'package:iris/ui/auth/register.dart';
import 'package:iris/ui/home/index.dart';
import 'package:provider/provider.dart';

import 'ui/themes/index.dart';

void main() {
  Global.init().then((_) => runApp(App()));
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //     statusBarColor: Colors.transparent,
  //     statusBarBrightness: Brightness.light));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // 全局变量
        ChangeNotifierProvider.value(value: UserModel()),
        ChangeNotifierProvider.value(value: ThemeModel())
      ],
      child: Consumer<ThemeModel>(
        builder: (context, themeModel, child) {
          return MaterialApp(
            title: 'IrisFlutter',
            theme: ThemeData(primarySwatch: themeModel.theme),
            home: HomePage(), // 首页
            routes: {
              "/login": (context) => LoginPage(), // 登录页
              "/themes": (context) => ThemeChangePage(), // 主题色切换页
              "/register": (context) => RegisterPage() // 注册页
            },
          );
        },
      ),
    );
  }
}
