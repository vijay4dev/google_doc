import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class DocModel {
  final String uid;
  final String title;
  final DateTime createdAt;
  final List content;
  final String id;
  DocModel({
    required this.uid,
    required this.title,
    required this.createdAt,
    required this.content,
    required this.id,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'title': title,
      'CreatedAt': createdAt.millisecondsSinceEpoch,
      'content': content,
      'id': id,
    };
  }

  factory DocModel.fromMap(Map<String, dynamic> map) {
    return DocModel(
      title: map['title'] ?? '',
      uid: map['uid'] ?? '',
      content: List.from(map['content']),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      id: map['_id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DocModel.fromJson(String source) => DocModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
