class Record {
  final String id;
  final String title;
  final DateTime date;

// constructor
  const Record({this.id, this.title, this.date});

  String get abbr {
    return title.substring(0, 2).toUpperCase();
  }

  Map<String, Object> toMap() {
    return {"title": title, "date": date};
  }
}
