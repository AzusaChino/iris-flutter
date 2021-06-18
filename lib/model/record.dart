class Record {
  Record();

  String id;
  String sid;
  String title; // 标题
  String episode; // 季集信息
  int status; // 作品状态
  int watched; // 观看状态
  int timestamp; // 时间戳

  double star; // 打分
  String visual; // KeyVisual
  String comment; // 评论

  factory Record.fromJson(Map<String, dynamic> json) {
    return Record()
      // id用于编辑
      ..id = json['id']
      ..sid = json['sid']
      ..title = json['title']
      ..episode = json['episode']
      ..status = json['status']
      ..watched = json['watched']
      ..timestamp = json['timestamp']
      ..star = json['star'] as double // 强制转型
      ..visual = json['visual']
      ..comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    return {
      "sid": sid,
      "title": title,
      "episode": episode,
      "timestamp": timestamp,
      "status": status,
      "watched": watched,
      "star": star,
      "comment": comment
    };
  }
}
