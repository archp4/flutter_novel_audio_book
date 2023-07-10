// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PopularNovels {
  final String name;
  final String imgSrc;
  final String bookRating;
  final String totalRead;
  final String href;

  PopularNovels({
    required this.name,
    required this.imgSrc,
    required this.bookRating,
    required this.totalRead,
    required this.href,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'imgSrc': imgSrc,
      'bookRating': bookRating,
      'totalRead': totalRead,
      'href': href,
    };
  }

  factory PopularNovels.fromMap(Map<String, dynamic> map) {
    return PopularNovels(
      name: map['name'] as String,
      imgSrc: map['imgSrc'] as String,
      bookRating: map['bookRating'] as String,
      totalRead: map['totalRead'] as String,
      href: map['href'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PopularNovels.fromJson(String source) =>
      PopularNovels.fromMap(json.decode(source) as Map<String, dynamic>);
}
