import 'package:flutter/material.dart';
import 'package:iris/model/index.dart';
import 'package:iris/provider/user_model.dart';
import 'package:iris/ui/home/section_list_item.dart';
import 'package:iris/utils/http_util.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _onSectionItemTapped(BuildContext context, Section section) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return null;
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Iris Capsule"),
      ),
      body: _buildBody(),
      drawer: _buildDrawer(),
    );
  }

  Widget _buildBody() {
    // retrieve data from Provider(ctx)
    UserModel userModel = Provider.of<UserModel>(context);
    if (!userModel.isLogin) {
      return Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("请先登录，再进行其他操作"),
          ElevatedButton(
            child: Text("登录"),
            onPressed: () => Navigator.of(context).pushNamed("/login"),
          )
        ],
      ));
    } else {
      return FutureBuilder<List<Section>>(
          future: HttpUtil().getSectionList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (!snapshot.hasError && snapshot.hasData) {
                return Padding(
                    padding: EdgeInsets.zero,
                    child: Column(
                      children: snapshot.data
                          .map((item) => SectionListItem(
                              section: item,
                              onTapped: (section) =>
                                  _onSectionItemTapped(context, section)))
                          .toList(growable: false),
                    ));
              } else {
                return Center(child: Text("发生错误或没有数据"));
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          });
    }
  }

  Widget _buildDrawer() {
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
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
              leading: const Icon(Icons.color_lens),
              title: Text("换肤"),
              onTap: () => Navigator.pushNamed(context, "/themes"),
            ),
            if (userModel.isLogin)
              ListTile(
                leading: const Icon(Icons.power_settings_new),
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
