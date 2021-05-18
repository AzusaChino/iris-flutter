import 'package:flutter/material.dart';

class ExplorePage extends StatelessWidget {
  void doExplore() {
    print("hello dart");
  }

  @override
  Widget build(BuildContext ctx) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("探索页"),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text('欢迎来到探索页'),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: doExplore,
        tooltip: "Go",
        child: new Icon(Icons.search),
      ),
    );
  }
}
