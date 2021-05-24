import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iris/model/index.dart';

// record详情页 TODO 编辑页
class RecordPage extends StatelessWidget {
  final Record record;
  RecordPage({Key key, this.record}) : super(key: key);

  _edit(BuildContext ctx, Record record) {
    print("编辑当前record");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(record.name),
        actions: [
          IconButton(onPressed: _edit(context, record), icon: Icon(Icons.edit))
        ],
      ),
      body: Material(
        child: Text(record.comment),
      ),
    );
  }
}
