import 'package:flutter/material.dart';
import 'package:iris/model/index.dart';

class RecordEditPage extends StatefulWidget {
  final Record record;

  RecordEditPage({Key key, this.record}) : super(key: key);

  @override
  _RecordEditPageState createState() => _RecordEditPageState();
}

class _RecordEditPageState extends State<RecordEditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("编辑")),
    );
  }
}
