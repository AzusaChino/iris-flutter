import 'package:flutter/material.dart';
import 'package:iris/common/theme.dart';
import 'package:iris/ui/login/index.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [],
      child: MaterialApp(
        title: 'LifeCase',
        theme: appTheme,
        initialRoute: "/",
        routes: {
          "/": (ctx) => Login(), // 登录页
          "/main": (ctx) => null, // 首页
          "/explore": (ctx) => null, // 探索页
          '/mine': (ctx) => null // 个人主页
        },
      ),
    );
  }
}
