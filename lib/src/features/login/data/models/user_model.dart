import 'dart:convert';

class UserModel {
  String username;
  String accessToken;
  UserModel({
    required this.username,
    required this.accessToken,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'] as String,
      accessToken: map['accessToken'] as String,
    );
  }

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
