// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserListModel {
  String id;
  String email;
  String first_name;
  String last_name;
  String avatar;
  UserListModel({
    required this.id,
    required this.email,
    required this.first_name,
    required this.last_name,
    required this.avatar,
  });

  UserListModel copyWith({
    String? id,
    String? email,
    String? first_name,
    String? last_name,
    String? avatar,
  }) {
    return UserListModel(
      id: id ?? this.id,
      email: email ?? this.email,
      first_name: first_name ?? this.first_name,
      last_name: last_name ?? this.last_name,
      avatar: avatar ?? this.avatar,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'first_name': first_name,
      'last_name': last_name,
      'avatar': avatar,
    };
  }

  factory UserListModel.fromMap(Map<String, dynamic> map) {
    return UserListModel(
      id: map['id'] as String,
      email: map['email'] as String,
      first_name: map['first_name'] as String,
      last_name: map['last_name'] as String,
      avatar: map['avatar'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserListModel.fromJson(String source) =>
      UserListModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserListModel(id: $id, email: $email, first_name: $first_name, last_name: $last_name, avatar: $avatar)';
  }

  @override
  bool operator ==(covariant UserListModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.email == email &&
        other.first_name == first_name &&
        other.last_name == last_name &&
        other.avatar == avatar;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        first_name.hashCode ^
        last_name.hashCode ^
        avatar.hashCode;
  }
}
