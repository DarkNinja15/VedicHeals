import 'dart:convert';

class BlogModel {
  final String heading;
  final String desc;
  final String image;
  BlogModel({
    required this.heading,
    required this.desc,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'heading': heading});
    result.addAll({'desc': desc});
    result.addAll({'image': image});

    return result;
  }

  factory BlogModel.fromMap(Map<String, dynamic> map) {
    return BlogModel(
      heading: map['heading'] ?? '',
      desc: map['desc'] ?? '',
      image: map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory BlogModel.fromJson(String source) =>
      BlogModel.fromMap(json.decode(source));
}
