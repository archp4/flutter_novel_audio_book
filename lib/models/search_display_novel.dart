import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class MainDisplayNovel {
  final String name;
  final String imgSrc;
  final String href;
  final List<dynamic> tags;
  final String lastChapterTime;
  final String bookRating;

  MainDisplayNovel({
    required this.name,
    required this.imgSrc,
    required this.href,
    required this.tags,
    required this.lastChapterTime,
    required this.bookRating,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'imgSrc': imgSrc,
      'href': href,
      'tags': tags,
      'lastChapterTime': lastChapterTime,
      'bookRating': bookRating,
    };
  }

  factory MainDisplayNovel.fromMap(Map<String, dynamic> map) {
    return MainDisplayNovel(
      name: map['name'] ?? '',
      imgSrc: map['imgSrc'] ?? '',
      href: map['href'] ?? '',
      tags: map['tags'] ?? '',
      lastChapterTime: map['lastestChapterTime'] ?? '',
      bookRating: map['bookRating'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MainDisplayNovel.fromJson(String source) =>
      MainDisplayNovel.fromMap(json.decode(source) as Map<String, dynamic>);
}
