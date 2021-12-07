import 'package:uService/models/user.dart';

class AuthResponse {
  String token;
  User user;

  AuthResponse() {
    this.token = '';
    this.user = User.fromJson({});
  }

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    AuthResponse auth = new AuthResponse();

    auth.token = json['access_token'] ?? '';
    auth.user = User.fromJson(json['user'] ?? {});

    return auth;
  }
}