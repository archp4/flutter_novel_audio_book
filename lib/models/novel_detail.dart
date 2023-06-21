// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:novel_audiobook_version/models/chapter.dart';

class NovelDetail {
  final String name;
  final String descrption;
  final String imgSrc;
  final List<Chapter> chapterList;
  NovelDetail({
    required this.name,
    required this.descrption,
    required this.imgSrc,
    required this.chapterList,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'descrption': descrption,
      'img_src': imgSrc,
      'chapters': chapterList.map((x) => x.toMap()).toList(),
    };
  }

  factory NovelDetail.fromMap(Map<String, dynamic> map) {
    return NovelDetail(
      name: map['name'] as String,
      descrption: map['descrption'] as String,
      imgSrc: map['img_src'] as String,
      chapterList: List<Chapter>.from(
        (map['chapters']).map<Chapter>(
          (x) => Chapter.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory NovelDetail.fromJson(String source) =>
      NovelDetail.fromMap(json.decode(source) as Map<String, dynamic>);
}
