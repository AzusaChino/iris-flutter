import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iris/common/global.dart';
import 'package:iris/model/index.dart';
import 'package:iris/provider/user_model.dart';
import 'package:iris/service/index.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  bool showPwd = false;
  GlobalKey _formKey = new GlobalKey<FormState>();
  bool _nameAutoFocus = true;

  @override
  void initState() {
    // 自动填充上次登录的用户名，填充后将焦点定位到密码输入框
    _unameController.text = Global.profile.lastLogin;
    if (_unameController.text != null) {
      _nameAutoFocus = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
        appBar: AppBar(title: Text("登录页")),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                TextFormField(
                  autofocus: _nameAutoFocus,
                  controller: _unameController,
                  decoration: InputDecoration(
                      labelText: "用户名",
                      hintText: "请输入用户名",
                      prefixIcon: Icon(Icons.person)),
                  validator: (v) {
                    return v.trim().isNotEmpty ? null : "用户名不能为空";
                  },
                ),
                TextFormField(
                  autofocus: !_nameAutoFocus,
                  controller: _pwdController,
                  decoration: InputDecoration(
                      labelText: "密码",
                      hintText: "请输入密码",
                      prefixIcon: Icon(Icons.lock),
                      suffix: IconButton(
                        icon: Icon(
                            showPwd ? Icons.visibility_off : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            showPwd = !showPwd;
                          });
                        },
                      )),
                  obscureText: !showPwd,
                  validator: (v) {
                    return v.trim().isNotEmpty ? null : "密码不能为空";
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: ConstrainedBox(
                    constraints: BoxConstraints.expand(height: 55.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                          onPrimary: Colors.white),
                      onPressed: _login,
                      child: Text("登录"),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  void _login() async {
    if ((_formKey.currentState as FormState).validate()) {
      User user;
      try {
        await login(
            username: _unameController.text, password: _pwdController.text);
        user = await getUser();
        Provider.of<UserModel>(context, listen: false).user = user;
      } catch (e) {
        print("登录时发生了异常: $e");
      }
      if (user != null) {
        Fluttertoast.showToast(
            msg: "登录成功!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.of(context).pop();
      } else {
        Fluttertoast.showToast(
            msg: "登录失败, 请重试",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }
}
