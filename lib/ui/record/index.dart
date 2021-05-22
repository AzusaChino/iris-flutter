import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iris/model/index.dart';

// record详情页 TODO 编辑页
class RecordPage extends StatelessWidget {
  final Record record;
  RecordPage({Key key, this.record}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(record.name),
      ),
    );
  }
}
