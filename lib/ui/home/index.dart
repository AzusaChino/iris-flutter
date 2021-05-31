import 'package:flutter/material.dart';
import 'package:iris/model/index.dart';
import 'package:iris/provider/user_model.dart';
import 'package:iris/service/section.dart';
import 'package:iris/ui/home/drawer.dart';
import 'package:iris/ui/home/section_list_item.dart';
import 'package:iris/ui/search/index.dart';
import 'package:iris/ui/section/index.dart';
import 'package:iris/utils/http_util.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const title = "Iris Flutter";

  void _onSectionItemTapped(BuildContext context, Section section) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => SectionPage(section: section)));
  }

  // 直接检索record
  void _search() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SearchPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: _buildBody(),
        drawer: MyDrawer(),
        floatingActionButton: _buildSearchButton());
  }

  Widget _buildSearchButton() {
    UserModel userModel = Provider.of<UserModel>(context);
    if (userModel.isLogin) {
      return IconButton(icon: Icon(Icons.search), onPressed: () => _search());
    } else {
      return null;
    }
  }

  Widget _buildBody() {
    // retrieve data from Provider(ctx)
    UserModel userModel = Provider.of<UserModel>(context);
    if (!userModel.isLogin) {
      return Padding(
        padding: EdgeInsets.only(top: 360),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("欢迎使用$title, 希望可以帮助到您.")],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 0, horizontal: 2)),
                  ),
                  onPressed: () => Navigator.of(context).pushNamed("/login"),
                  child: Text(
                    '登录',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                )
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "如果你没有帐户的话, ",
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.black),
                ),
                TextButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 0, horizontal: 2)),
                  ),
                  onPressed: () => Navigator.of(context).pushNamed("/register"),
                  child: Text(
                    "请先注册",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else {
      return FutureBuilder<List<Section>>(
          future: getSectionList(),
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
}
