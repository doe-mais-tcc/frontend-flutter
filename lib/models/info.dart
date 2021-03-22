class Info {
  String title;
  List<String> items;

  Info({this.title, this.items});

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      title: json['title'],
      items: List.castFrom(json['items']).cast<String>(),
    );
  }
}
