import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iris/common/enum.dart';
import 'package:iris/model/index.dart';

// record详情页
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
      body: Container(
        // decoration: BoxDecoration(
        //     border: Border.all(color: Colors.white, width: .5),
        //     image: DecorationImage(
        //         image: AssetImage("imgs/background.jpg"), fit: BoxFit.fill)),
        padding: EdgeInsets.only(top: 60),
        child: Padding(
          padding: EdgeInsets.only(top: 8, left: 8, right: 8),
          child: Padding(
            padding: EdgeInsets.only(top: 0.0, bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    children: [
                      Text(RecordStatus[record.status]),
                      SizedBox(width: 8),
                      Text(WatchStatus[record.watched]),
                      SizedBox(width: 8),
                      Text(record.comment)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
