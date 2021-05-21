import 'package:flutter/material.dart';
import 'package:iris/model/index.dart';

class RecordItem extends StatefulWidget {
  final Record record;

  RecordItem(this.record) : super(key: ValueKey(record.id));

  @override
  _RecordItemState createState() => _RecordItemState();
}

class _RecordItemState extends State<RecordItem> {
  @override
  Widget build(BuildContext ctx) {
    return null;
  }
}
