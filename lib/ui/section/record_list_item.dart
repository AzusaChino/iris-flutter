import 'package:flutter/material.dart';
import 'package:iris/common/common.dart';
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

        // decoration: BoxDecoration(
        //     border: Border.all(color: Colors.white, width: .5),
        //     image: DecorationImage(
        //         image:
        // 展示当前作品的Key Visual
        //             AssetImage("imgs/background.jpg"),
        //         fit: BoxFit.cover)),
        // padding: EdgeInsets.only(top: 50.0),
        child: Padding(
            padding: EdgeInsets.only(top: 8, right: 8, left: 8),
            child: Card(
              child: InkWell(
                splashColor: Theme.of(context).splashColor.withAlpha(30),
                onTap: () => onTapped(record),
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
                                Text(record.title,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black.withOpacity(.8))),
                                Padding(
                                  padding: EdgeInsets.only(top: 8, bottom: 12),
                                  child: Row(
                                    children: [
                                      Row(children: [
                                        Text(
                                          record.episode,
                                        ),
                                        SizedBox(width: 4),
                                        Text(RECORD_STAUS_MAP[record.status]),
                                        SizedBox(width: 14),
                                        Text(formatTimestamp(record.timestamp)),
                                      ]),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ])),
              ),
            )));
  }
}
