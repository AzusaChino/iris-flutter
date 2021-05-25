class Record {
  Record();

  String id;
  String sid;
  // String uname;
  String name;
  String episode;
  String status; // 作品状态
  String watched; // 观看状态
  int timestamp;

  double star;
  String visual;
  String comment;

  factory Record.fromJson(Map<String, dynamic> json) {
    return Record()
      // id用于编辑
      ..id = json['id']
      ..sid = json['sid']
      ..name = json['name']
      ..episode = json['episode']
      ..status = json['status']
      ..watched = json['watched']
      ..timestamp = json['timestamp']
      ..star = json['star']
      ..visual = json['visual']
      ..comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    return {"sid": this.sid};
  }
}
