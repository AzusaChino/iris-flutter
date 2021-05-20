class Record {
  Record();

  String id;
  String sid;
  String name;
  String date;
  String season;
  String episode;
  String visual;
  String star;
  String comment;

  factory Record.fromJson(Map<String, dynamic> json) {
    return Record()
      ..name = json['name']
      ..date = json['date']
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
