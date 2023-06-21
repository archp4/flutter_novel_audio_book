// ignore_for_file: public_member_api_docs, sort_constructors_first

class ReaderChapter {
  final String name;
  final String data;
  ReaderChapter({
    required this.name,
    required this.data,
  });

  ReaderChapter copyWith({
    String? name,
    String? data,
  }) {
    return ReaderChapter(
      name: name ?? this.name,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'data': data,
    };
  }

  factory ReaderChapter.fromMap(Map<String, dynamic> map) {
    return ReaderChapter(
      name: map['name'] as String,
      data: map['data'] as String,
    );
  }
}
