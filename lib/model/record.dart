class Record {
  Record();

  String id;
  String sid;
  String name;
  int timestamp;
  String season;
  String episode;
  String visual;
  double star;
  String comment;

  factory Record.fromJson(Map<String, dynamic> json) {
    return Record()
      // id用于编辑
      ..id = json['id']
      ..sid = json['sid']
      ..name = json['name']
      ..timestamp = json['timestamp']
      ..season = json['season']
      ..episode = json['episode']
      ..visual = json['visual']
      ..star = json['star']
      ..comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    return {"sid": this.sid};
  }
}
