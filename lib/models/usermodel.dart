import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Usermodel {
  final String pfp;
  final String name;
  final String email;
  final String token;
  final String uid;
  Usermodel({
    required this.pfp,
    required this.name,
    required this.email,
    required this.token,
    required this.uid
  });



  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pfp': pfp,
      'name': name,
      'email': email,
      'token': token,
    };
  }

  factory Usermodel.fromMap(Map<String, dynamic> map) {
    return Usermodel(
      pfp: map['pfp'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      token: map['token'] as String,
      uid: map['_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Usermodel.fromJson(String source) => Usermodel.fromMap(json.decode(source) as Map<String, dynamic>);

  Usermodel copyWith({
    String? pfp,
    String? name,
    String? email,
    String? token,
    String? uid,
  }) {
    return Usermodel(
      pfp: pfp ?? this.pfp,
      name: name ?? this.name,
      email: email ?? this.email,
      token: token ?? this.token,
      uid: uid ?? this.uid,
    );
  }
}
