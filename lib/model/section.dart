class Section {
  Section();

  String id;
  String name;
  String visual;

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section()
      ..id = json['id']
      ..name = json['name']
      ..visual = json['visual'];
  }
}
