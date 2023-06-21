// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SearchDisplayNovel {
  final String name;
  final String imgSrc;
  final String href;
  SearchDisplayNovel({
    required this.name,
    required this.imgSrc,
    required this.href,
  });

  SearchDisplayNovel copyWith({
    String? name,
    String? imgSrc,
    String? href,
  }) {
    return SearchDisplayNovel(
      name: name ?? this.name,
      imgSrc: imgSrc ?? this.imgSrc,
      href: href ?? this.href,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'img_src': imgSrc,
      'href': href,
    };
  }

  factory SearchDisplayNovel.fromMap(Map<String, dynamic> map) {
    return SearchDisplayNovel(
      name: map['name'] as String,
      imgSrc: map['img_src'] as String,
      href: map['href'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SearchDisplayNovel.fromJson(String source) =>
      SearchDisplayNovel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'SearchDisplayNovel(name: $name, img_src: $imgSrc, href: $href)';

  @override
  bool operator ==(covariant SearchDisplayNovel other) {
    if (identical(this, other)) return true;

    return other.name == name && other.imgSrc == imgSrc && other.href == href;
  }

  @override
  int get hashCode => name.hashCode ^ imgSrc.hashCode ^ href.hashCode;
}
