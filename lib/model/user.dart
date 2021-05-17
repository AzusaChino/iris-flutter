enum AuthStatus { loading, error, authed, unauthed }

class AuthState {
  final AuthStatus authStatus;
  final String authError;

  AuthState(this.authStatus, this.authError);
}

class User {
  final String id;
  final String username;
  final String avatar;

  const User({this.id, this.username, this.avatar});

  Map<String, Object> toMap() {
    if (id == null) {
      return {'username': username, 'avatar': avatar};
    }
    return {'id': id, 'username': username, 'avatar': avatar};
  }
}
