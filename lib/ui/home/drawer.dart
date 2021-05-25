import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iris/provider/user_model.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_buildHeader(), Expanded(child: _buildMenus())],
          )),
    );
  }

  Widget _buildHeader() {
    return Consumer<UserModel>(
      builder: (BuildContext ctx, UserModel model, Widget child) {
        return GestureDetector(
          child: Container(
            color: Theme.of(ctx).primaryColor,
            padding: EdgeInsets.only(top: 40, bottom: 20),
            child: Row(
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: ClipOval(
                      child: Image.asset("imgs/avatar-default.jpg", width: 80),
                    )),
                // child: model.isLogin
                //     ? Image.network(model.user.avatar, width: 80)
                //     : Image.asset("imgs/avatar-default.jpg",
                //         width: 80))),
                Text(model.isLogin ? model.user.username : "登录",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white))
              ],
            ),
          ),
          onTap: () {
            if (!model.isLogin) {
              Navigator.of(ctx).pushNamed("/login");
            }
          },
        );
      },
    );
  }

  Widget _buildMenus() {
    return Consumer<UserModel>(
      builder: (BuildContext context, UserModel userModel, Widget child) {
        return ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.color_lens),
              title: Text("换肤"),
              onTap: () => Navigator.of(context).pushNamed("/themes"),
            ),
            if (userModel.isLogin)
              ListTile(
                leading: Icon(Icons.power_settings_new),
                title: Text("注销"),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (ctx) {
                      //退出账号前先弹二次确认窗
                      return AlertDialog(
                        content: Text("确认退出吗?"),
                        actions: <Widget>[
                          TextButton(
                            child: Text("取消"),
                            onPressed: () => Navigator.pop(context),
                          ),
                          TextButton(
                            child: Text("确定"),
                            onPressed: () {
                              //该赋值语句会触发MaterialApp rebuild
                              userModel.user = null;
                              Fluttertoast.showToast(
                                  msg: "注销成功",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.TOP,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
          ],
        );
      },
    );
  }
}
