class Section {
  Section();

  String id;
  String name;
  String src;

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section()
      ..name = json['name']
      ..src = json['src'];
  }
}
