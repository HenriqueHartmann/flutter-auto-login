import 'dart:convert';

import 'package:auto_login_app/src/core/error/failure.dart';

class AuthModel {
  final String login;
  final String password;
  AuthModel({
    required this.login,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': login,
      'password': password,
    };
  }

  String toJson() => json.encode(toMap());

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    try {
      return AuthModel(
        login: map['username'] as String,
        password: map['password'] as String,
      );
    } catch (e) {
      throw SerializerFailure();
    }
  }

  factory AuthModel.fromJson(String source) =>
      AuthModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
