import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RecordNewPage extends StatefulWidget {
  @override
  _RecordNewPageState createState() => _RecordNewPageState();
}

class _RecordNewPageState extends State<RecordNewPage> {
  GlobalKey _formKey = new GlobalKey<FormState>();
  TextEditingController _titleController = new TextEditingController();
  double _ratting = 1.0;
  bool _statusSelected = false;
  bool _watchSelected = false;
  TextEditingController _commentController = new TextEditingController();
// TODO 上传图片

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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(
                          labelText: "作品标题",
                          hintText: "请输入作品标题",
                          prefixIcon: Icon(Icons.movie)),
                    ),
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(
                          labelText: "当前进度",
                          hintText: "请输入当前进度(第xx话)",
                          prefixIcon: Icon(Icons.access_time_rounded)),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      CheckboxListTile(
                        title: Text("是否完结"),
                        controlAffinity: ListTileControlAffinity.leading,
                        value: _statusSelected,
                        onChanged: (value) {
                          setState(() {
                            _statusSelected = value;
                          });
                        },
                      ),
                      SizedBox(width: 30),
                      CheckboxListTile(
                          title: Text("是否看完"),
                          controlAffinity: ListTileControlAffinity.leading,
                          value: _watchSelected,
                          onChanged: (val) {
                            setState(() {
                              _watchSelected = val;
                            });
                          })
                    ]),
                    RatingBar.builder(
                      initialRating: 3.0,
                      minRating: _ratting,
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
                    ),
                    TextFormField(
                      controller: _commentController,
                      decoration: InputDecoration(
                          labelText: "评论",
                          hintText: "请输入评论",
                          prefix: Icon(Icons.comment)),
                    ),
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
                  ]))),
    );
  }

  void _submit() async {}
}
