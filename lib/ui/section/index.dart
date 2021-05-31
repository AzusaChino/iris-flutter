import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:iris/model/index.dart';
import 'package:iris/service/record.dart';
import 'package:iris/ui/record/index.dart';
import 'package:iris/ui/record/create.dart';
import 'package:iris/ui/section/record_list_item.dart';

class SectionPage extends StatelessWidget {
  final Section section;

  SectionPage({this.section});

  void _onRecordItemTapped(BuildContext ctx, Record record) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (context) {
      return RecordPage(record: record);
    }));
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
        appBar: AppBar(title: Text(section.name), actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.of(ctx)
                .push(MaterialPageRoute(builder: (ctx) => RecordCreatePage())),
          )
        ]),
        body: InfiniteListView(onRetrieveData: (page, items, refresh) async {
          var id = this.section.id;
          var data = await getRecordList(
              sid: id,
              params: {"pageIndex": page, "pageSize": 5}, // 每次仅加载5条record
              refresh: refresh);
          items.addAll(data);
          return data.length == 10;
        }, itemBuilder: (list, index, ctx) {
          return Padding(
              padding: EdgeInsets.zero,
              child: RecordListItem(
                  record: list[index],
                  onTapped: (record) => _onRecordItemTapped(ctx, record)));
        }));
  }
}
