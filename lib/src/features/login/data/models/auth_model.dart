import 'dart:convert';

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
}
