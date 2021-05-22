class Section {
  Section();

  String id;
  String name;
  String src;

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section()
      ..id = json['id']
      ..name = json['name']
      ..src = json['src'];
  }
}
