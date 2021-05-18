import 'package:flutter/material.dart';
import 'package:iris/model/user.dart';
import 'package:iris/service/user_service.dart';

class LoginViewModel extends ChangeNotifier {
  UserService _userService;

  LoginViewModel({UserService userService}) : _userService = userService;

  String _username = "";
  String _password = "";
  AuthState _state;

  AuthState get state {
    return _state;
  }

  set email(String email) {
    this._username = email;
  }

  set password(String password) {
    this._password = password;
  }

  void resetState() {
    _state = AuthState(AuthStatus.unauthed, null);
  }

  void loginUser() async {
    this._state =
        await _userService.login(username: _username, password: _password);

    if (this._state.authStatus == AuthStatus.authed) {
      _username = "";
      _password = "";
    }

    notifyListeners();
  }
}
