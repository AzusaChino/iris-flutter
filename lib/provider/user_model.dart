import 'package:iris/provider/profile_change_notifier.dart';
import 'package:iris/model/index.dart';

class UserModel extends ProfileChangeNotifier {
  User get user => profile.user;

  bool get isLogin => user != null;

  // 用户信息发生变化，更新用户信息并通知依赖它的子孙Widgets更新
  set user(User user) {
    // not same user
    if (user?.username != profile.user?.username) {
      profile.lastLogin = profile.user?.username;
      profile.user = user;
      notifyListeners();
    }
  }
}
