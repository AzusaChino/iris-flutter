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
      ..name = json['name'] as String
      ..date = json['date'] as String
      ..season = json['season'] as String
      ..episode = json['episode'] as String
      ..visual = json['visual'] as String
      ..star = json['star'] as String
      ..comment = json['comment'] as String;
  }
}
