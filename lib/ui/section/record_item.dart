import 'package:flutter/material.dart';
import 'package:iris/model/index.dart';
import 'package:iris/utils/date_util.dart';

// record列表展示子元素
class RecordListItem extends StatelessWidget {
  final Record record;
  final Function(Record) onTapped;

  RecordListItem({Key key, this.record, this.onTapped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: .5),
          image: DecorationImage(
              image:
                  // 展示当前作品的Key Visual
                  Image.asset("imgs/background.jpg").image,
              fit: BoxFit.fill)),
      child: Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Material(
          color: Colors.white,
          shape: BorderDirectional(
              bottom:
                  BorderSide(color: Theme.of(context).dividerColor, width: .5)),
          child: Padding(
            padding: EdgeInsets.only(top: 0.0, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(record.name,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      Padding(
                        padding: EdgeInsets.only(top: 8, bottom: 12),
                        child: Row(
                          children: [
                            Text(formatTimestamp(record.timestamp)),
                            SizedBox(width: 16),
                            record.season == null
                                ? Text(record.episode)
                                : Row(children: [
                                    Text(record.season),
                                    SizedBox(width: 2),
                                    Text(record.episode)
                                  ]),
                          ],
                        ),
                      )
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
