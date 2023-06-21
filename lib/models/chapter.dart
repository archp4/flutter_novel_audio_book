import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Chapter {
  String name;
  String addressNo;
  Chapter({
    required this.name,
    required this.addressNo,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'addressNo': addressNo,
    };
  }

  factory Chapter.fromMap(Map<String, dynamic> map) {
    return Chapter(
      name: map['name'] as String,
      addressNo: map['href'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Chapter.fromJson(String source) =>
      Chapter.fromMap(json.decode(source) as Map<String, dynamic>);
}
