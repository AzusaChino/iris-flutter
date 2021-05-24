import 'package:flutter/material.dart';
import 'package:iris/model/index.dart';
import 'package:iris/provider/user_model.dart';
import 'package:iris/ui/home/drawer.dart';
import 'package:iris/ui/home/section_list_item.dart';
import 'package:iris/ui/section/index.dart';
import 'package:iris/utils/http_util.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _onSectionItemTapped(BuildContext context, Section section) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return SectionPage(section: section);
    }));
  }

  // 直接检索record
  void _search() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Iris Capsule"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => _search(),
          )
        ],
      ),
      body: _buildBody(),
      drawer: MyDrawer(),
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
}
