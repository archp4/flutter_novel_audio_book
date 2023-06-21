// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DisplayNovel {
  final String name;
  final String imgSrc;
  final String lastestChapterNumber;
  final String lastestChapterTime;
  final String href;

  DisplayNovel({
    required this.name,
    required this.imgSrc,
    required this.lastestChapterNumber,
    required this.lastestChapterTime,
    required this.href,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'img_src': imgSrc,
      'lastest_chapter_number': lastestChapterNumber,
      'lastest_chapter_time': lastestChapterTime,
      'href': href,
    };
  }

  factory DisplayNovel.fromMap(Map<String, dynamic> map) {
    return DisplayNovel(
      name: map['name'] as String,
      imgSrc: map['img_src'] as String,
      lastestChapterNumber: map['lastest_chapter_number'] as String,
      lastestChapterTime: map['lastest_chapter_time'] as String,
      href: map['href'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DisplayNovel.fromJson(String source) =>
      DisplayNovel.fromMap(json.decode(source) as Map<String, dynamic>);
}
