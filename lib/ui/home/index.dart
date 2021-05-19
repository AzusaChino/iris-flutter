import 'package:flutter/material.dart';

class HomeRoute extends StatefulWidget {
  @override
  HomeRouteState createState() => HomeRouteState();
}

class HomeRouteState extends State<HomeRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: buildBody(),
      drawer: buildDrawer(),
    );
  }

  Widget buildBody() {
    return Center();
  }

  Widget buildDrawer() {
    return Drawer();
  }
}
