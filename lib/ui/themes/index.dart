import 'package:flutter/material.dart';
import 'package:iris/common/global.dart';
import 'package:iris/provider/theme_model.dart';
import 'package:provider/provider.dart';

class ThemeChangePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("选择主题色"),
      ),
      body: ListView(
        //显示主题色块
        children: Global.themes.map<Widget>((item) {
          return GestureDetector(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
              child: Container(
                color: item,
                height: 40,
              ),
            ),
            onTap: () {
              //主题更新后，MaterialApp会重新build
              Provider.of<ThemeModel>(context).theme = item;
            },
          );
        }).toList(),
      ),
    );
  }
}
