import 'package:flutter/material.dart';
import 'package:iris/common/theme.dart';
import 'package:iris/service/user_service.dart';
import 'package:iris/ui/explore/index.dart';
import 'package:iris/ui/login/index.dart';
import 'package:iris/ui/login/login_view_model.dart';
import 'package:iris/ui/login/register_view_model.dart';
import 'package:iris/ui/main/index.dart';
import 'package:iris/ui/mine/index.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userService = UserService();
    return MultiProvider(
      providers: [
        Provider<UserService>(create: (_) => userService),
        ChangeNotifierProvider<LoginViewModel>(
            create: (_) => LoginViewModel(userService: userService)),
        ChangeNotifierProvider<RegisterViewModel>(
            create: (_) => RegisterViewModel(userService: userService)),
        StreamProvider(
            create: (ctx) => userService.authStateChanges, initialData: null)
      ],
      child: MaterialApp(
        title: 'Iris',
        theme: appTheme,
        initialRoute: "/",
        routes: {
          "/": (ctx) => LoginPage(), // 登录页
          "/main": (ctx) => MainPage(), // 首页
          "/explore": (ctx) => ExplorePage(), // 探索页
          '/mine': (ctx) => MinePage() // 个人主页
        },
      ),
    );
  }
}
