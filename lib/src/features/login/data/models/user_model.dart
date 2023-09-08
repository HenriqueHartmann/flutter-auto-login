import 'dart:convert';

import 'package:auto_login_app/src/core/error/failure.dart';

class UserModel {
  String username;
  String accessToken;
  UserModel({
    required this.username,
    required this.accessToken,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    try {
      return UserModel(
        username: map['username'] as String,
        accessToken: map['accessToken'] as String,
      );
    } catch (e) {
      throw SerializerFailure();
    }
  }

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
