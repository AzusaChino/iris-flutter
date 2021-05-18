main(List<String> args) {
  var d = Dart();
  d.a();
}

class Dart {
  a() {
    Future.delayed(new Duration(seconds: 2), () {
      return "Hello Dart";
    }).then((d) {
      print(d);
    }).catchError((e) {
      print(e);
    });
  }

  task() async {
    try {
      await login();
      await getUserInfo();
      await saveUserInfo();
    } catch (e) {
      print(e);
    }
  }

  login() async {}

  getUserInfo() async {}

  saveUserInfo() async {}

  b() {
    Stream.fromFutures([
      Future.delayed(new Duration(seconds: 2), () {
        return "Hello 1";
      }),
      Future.delayed(new Duration(seconds: 4), () {
        throw AssertionError("error");
      })
    ]).listen((data) {
      print(data);
    }, onError: (e) {
      print(e.message);
    }, onDone: () {});
  }
}
