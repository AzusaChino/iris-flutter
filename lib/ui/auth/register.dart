import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iris/service/index.dart';
import 'package:iris/utils/http_util.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _unameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  TextEditingController _repeatPassController = new TextEditingController();

  GlobalKey _formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("注册页")),
      body: Padding(
          padding: EdgeInsets.all(24.0),
          child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'A Humble Welcome to You (*^_^*)',
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _unameController,
                    obscureText: false,
                    validator: (v) {
                      return v.trim().isNotEmpty ? null : "用户名不能为空";
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '用户名',
                        hintText: "请输入用户名",
                        prefixIcon: Icon(Icons.person)),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    obscureText: false,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      return _validateEmail(value);
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '邮箱',
                        hintText: "请输入邮箱",
                        prefixIcon: Icon(Icons.email)),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _passController,
                    obscureText: true,
                    validator: (value) {
                      return _validatePassword(value);
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '密码',
                      hintText: "请输入密码",
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _repeatPassController,
                    obscureText: true,
                    validator: (value) {
                      return _validatePasswordMatch(value);
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '确认密码',
                      hintText: "请确认密码",
                      prefixIcon: Icon(Icons.lock_outline),
                    ),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _register(),
                      child: Text(
                        '注册',
                        style: TextStyle(color: Colors.grey.shade100),
                      ),
                    ),
                  )
                ],
              ))),
    );
  }

  String _validateEmail(String val) {
    if (EmailValidator.validate(val)) {
      return null;
    }
    return "邮箱格式错误";
  }

  String _validatePassword(String val) {
    if (val.length > 5) {
      return null;
    }
    return "密码太短";
  }

  String _validatePasswordMatch(String val) {
    var pass = _passController.text;
    if (val == pass) {
      return null;
    }
    return "密码不匹配";
  }

  void _register() async {
    if ((_formKey.currentState as FormState).validate()) {
      var result;
      try {
        result = await register(
            username: _unameController.text,
            email: _emailController.text,
            password: _passController.text);
      } catch (e) {
        print("注册时发生了错误:$e");
      }
      if (result) {
        Fluttertoast.showToast(
            msg: "注册成功, 请进行登录",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.of(context).pop();
      } else {
        Fluttertoast.showToast(
            msg: "注册失败",
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
