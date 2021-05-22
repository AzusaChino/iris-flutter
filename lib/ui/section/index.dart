import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:iris/model/index.dart';
import 'package:iris/ui/section/record_item.dart';
import 'package:iris/utils/http_util.dart';

class SectionPage extends StatelessWidget {
  final Section section;

  SectionPage({this.section});

  void _onRecordItemTapped(BuildContext ctx, Record record) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (context) {
      return Text(record.name);
    }));
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
        appBar: AppBar(title: Text(section.name), actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => null,
          )
        ]),
        // TODO 分页
        body: InfiniteListView(onRetrieveData: (page, items, refresh) async {
          var data = await HttpUtil().getRecordList(this.section.id);
          items.addAll(data);
          return false;
        }, itemBuilder: (list, index, ctx) {
          return Padding(
              padding: EdgeInsets.zero,
              child: RecordListItem(
                  record: list[index],
                  onTapped: (record) => _onRecordItemTapped(ctx, record)));
        }));
  }
}
