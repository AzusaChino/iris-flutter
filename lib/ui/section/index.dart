import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:iris/model/index.dart';
import 'package:iris/service/record.dart';
import 'package:iris/ui/record/create.dart';
import 'package:iris/ui/record/index.dart';
import 'package:iris/ui/section/record_list_item.dart';

class SectionPage extends StatefulWidget {
  final Section section;

  SectionPage({Section section, Key key})
      : this.section = section,
        super(key: key);

  @override
  _SectionPageState createState() => _SectionPageState();
}

class _SectionPageState extends State<SectionPage> {
  var name, id;

  @override
  void initState() {
    super.initState();
    name = widget.section.name;
    id = widget.section.id;
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
        appBar: AppBar(title: Text(name), actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.of(ctx).push(
                MaterialPageRoute(builder: (ctx) => RecordCreatePage(sid: id))),
          )
        ]),
        body: InfiniteListView(onRetrieveData: (page, items, refresh) async {
          var id = this.id;
          var data = await getRecordList(
              sid: id,
              params: {"pageIndex": page, "pageSize": 5}, // 每次仅加载5条record
              refresh: refresh);
          items.addAll(data);
          return data.length == 5;
        }, itemBuilder: (list, index, ctx) {
          return Padding(
              padding: EdgeInsets.zero,
              child: RecordListItem(
                  record: list[index],
                  onTapped: (record) => _onRecordItemTapped(ctx, record)));
        }));
  }

  void _onRecordItemTapped(BuildContext ctx, Record record) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (context) {
      return RecordPage(record: record);
    }));
  }
}
