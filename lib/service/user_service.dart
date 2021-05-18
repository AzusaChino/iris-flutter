import 'package:dio/dio.dart';
import 'package:iris/model/user.dart';

class UserService {
  final Dio dio = new Dio();

  UserService();

  Stream<User> get authStateChanges => Stream.empty();

  Future<AuthState> login({String username, String password}) async {
    try {
      var res = await dio
          .post("/login", data: {'username': username, 'password': password});
      if (res.statusCode == 200) {
        return AuthState(AuthStatus.authed, null);
      }
      return AuthState(AuthStatus.unauthed, 'error');
    } catch (e) {
      return AuthState(AuthStatus.error, e.toString());
    }
  }

  Future<AuthState> register({String username, String password}) async {
    try {
      var res = await dio.post('/register', data: {username, password});
      if (res.statusCode == 200) {
        return AuthState(AuthStatus.authed, null);
      }
      return AuthState(AuthStatus.unauthed, 'error');
    } catch (e) {
      return AuthState(AuthStatus.error, e.toString());
    }
  }

  Future<void> logout({String username}) async {
    await dio.post('/logout', data: {username});
  }
}
