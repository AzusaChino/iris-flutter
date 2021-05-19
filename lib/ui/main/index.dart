import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Iris"),
      ),
      body: new Center(
        child: new Text("Main Page"),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () => Navigator.pushReplacementNamed(ctx, "/explore"),
        child: new Text('探索'),
      ),
    );
  }
}
