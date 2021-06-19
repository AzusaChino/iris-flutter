import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iris/common/common.dart';
import 'package:iris/model/index.dart';
import 'package:iris/service/record.dart';
import 'package:iris/utils/date_util.dart';

class RecordCreatePage extends StatefulWidget {
  final String sid;
  RecordCreatePage({String sid, Key key})
      : this.sid = sid,
        super(key: key);

  @override
  _RecordCreatePageState createState() => _RecordCreatePageState();
}

class _RecordCreatePageState extends State<RecordCreatePage> {
  GlobalKey _formKey = new GlobalKey<FormState>();

  String _sid;
  TextEditingController _titleController = new TextEditingController();
  TextEditingController _episodeController = new TextEditingController();
  double _ratting = 1.0;
  bool _statusSelected = false;
  bool _watchSelected = false;
  TextEditingController _commentController = new TextEditingController();
  // TODO 上传图片

  @override
  void initState() {
    super.initState();
    _sid = widget.sid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("新增Record")),
        body: Padding(
            padding: EdgeInsets.all(12.0),
            child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _titleController,
                        decoration: InputDecoration(
                            labelText: "作品标题",
                            hintText: "请输入作品标题",
                            prefixIcon: Icon(Icons.movie)),
                      ),
                      TextFormField(
                        controller: _episodeController,
                        decoration: InputDecoration(
                            labelText: "当前进度",
                            hintText: "请输入当前进度",
                            prefixIcon: Icon(Icons.access_time_rounded)),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("是否完结"),
                            SizedBox(width: 2),
                            Checkbox(
                              // title: Text("是否完结"),
                              // controlAffinity: ListTileControlAffinity.leading,
                              value: _statusSelected,
                              onChanged: (value) {
                                setState(() {
                                  _statusSelected = value;
                                });
                              },
                            ),
                            SizedBox(width: 16),
                            Text("是否看完"),
                            SizedBox(width: 2),
                            Checkbox(
                                // title: Text("是否看完"),
                                // controlAffinity:
                                //     ListTileControlAffinity.leading,
                                value: _watchSelected,
                                onChanged: (val) {
                                  setState(() {
                                    _watchSelected = val;
                                  });
                                })
                          ]),
                      Row(
                        children: [
                          Text("评分"),
                          SizedBox(width: 12),
                          RatingBar.builder(
                            itemSize: 20.0,
                            initialRating: _ratting,
                            minRating: 0.5,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (ctx, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (ratting) {
                              setState(() {
                                _ratting = ratting;
                              });
                            },
                            updateOnDrag: true,
                          ),
                        ],
                      ),
                      TextFormField(
                        controller: _commentController,
                        decoration: InputDecoration(
                            labelText: "评论",
                            hintText: "请输入评论",
                            prefixIcon: Icon(Icons.comment)),
                      ),
                      SizedBox(height: 3),
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: ConstrainedBox(
                          constraints: BoxConstraints.expand(height: 55.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Theme.of(context).primaryColor,
                                onPrimary: Colors.white),
                            onPressed: _submit,
                            child: Text("提交"),
                          ),
                        ),
                      )
                    ]))));
  }

  void _submit() async {
    if ((_formKey.currentState as FormState).validate()) {
      var record = Record();
      record.sid = _sid;
      record.title = _titleController.text;
      record.episode = _episodeController.text;
      record.timestamp = getTimestamp();
      record.status = STATUS_MAP[_statusSelected];
      record.watched = WATCH_MAP[_watchSelected];
      record.star = _ratting;
      record.comment = _commentController.text;

      var res = await insertRecord(record: record);

      if (res != null) {
        Navigator.pushNamed(context, "/");
      }
    }
  }
}
