import 'package:flutter/material.dart';
import 'package:iris/model/user.dart';
import 'package:iris/service/user_service.dart';

class RegisterViewModel extends ChangeNotifier {
  UserService _userService;

  RegisterViewModel({UserService userService}) : _userService = userService;

  String _username = "";
  String _password = "";
  String _confirmedPassword = "";
  AuthState _state;

  AuthState get state {
    return _state;
  }

  void resetState() {
    _state = AuthState(AuthStatus.unauthed, null);
  }

  String get email {
    return _username;
  }

  String get password {
    return _password;
  }

  String get confirmedPassword {
    return _confirmedPassword;
  }

  String validatePassword(String password) {
    this._password = password;
    if (password.length > 5) {
      return null;
    }
    return "Password must be at least 6 characters long.";
  }

  String validatePasswordMatch(String confirmedPassword) {
    _confirmedPassword = confirmedPassword;
    if (this._password == confirmedPassword) {
      return null;
    }
    return "Passwords must match.";
  }

  void registerUser() async {
    // if (!EmailValidator.validate(email)) {
    //   this._state = AuthState(AuthStatus.error, "Please enter a valid email.");
    //   notifyListeners();
    //   return;
    // }

    if (password != confirmedPassword) {
      this._state = AuthState(AuthStatus.error, "Passwords need to match.");
      notifyListeners();
      return;
    }

    this._state = AuthState(AuthStatus.loading, null);
    notifyListeners();

    this._state =
        await _userService.register(username: _username, password: _password);

    if (this._state.authStatus == AuthStatus.authed) {
      _username = "";
      _password = "";
      _confirmedPassword = "";
    }

    notifyListeners();
  }
}
