import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gibspons/auth/domain/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

abstract class AuthRepository {
  Future<void> register({
    required String name,
    required String email,
    required String password,
  });
  Future<void> login({
    required String email,
    required String password,
  });
  Future<void> logout();
  Future<bool> isLoggedIn();
  Future<String> getToken();
  Future<void> refreshToken();
  Future<void> resetPassword({
    required String email,
  });
}

class DjangoAuthRepository extends AuthRepository {
  final String url = dotenv.env['BASE_URL']!;

  @override
  Future<String> getToken() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'access_token');
    if (token != null) {
      return token;
    } else {
      throw Exception("Token not found");
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    const storage = FlutterSecureStorage();
    final String? token = await storage.read(key: 'access_token');
    if (token != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<void> login({
    required String email,
    required String password,
  }) async {
    final res = await http.post(
      Uri.parse("${url}users/login/"),
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
      headers: {
        "Content-Type": "application/json",
      },
    );
    if (res.statusCode == 200) {
      const storage = FlutterSecureStorage();
      final Map<String, dynamic> data = jsonDecode(res.body);
      final String accessToken = data['data']['access_token'];
      final String refreshToken = data['data']['refresh_token'];
      final UserModel user = UserModel(
        name: data['data']['name'],
        username: data['data']['username'],
        email: data['data']['email'],
        organisation: data['data']['organisation'],
        role: data['data']['role'],
      );
      await storage.write(key: 'user', value: jsonEncode(user));
      await storage.write(key: 'access_token', value: accessToken);
      await storage.write(key: 'refresh_token', value: refreshToken);
      return;
    } else {
      throw Exception("${res.body} - ${res.statusCode}");
    }
  }

  @override
  Future<void> logout() async {
    final res = await http.post(
      Uri.parse("${url}users/logout/"),
    );
    if (res.statusCode == 200) {
      const storage = FlutterSecureStorage();
      await storage.delete(key: 'access_token');
      await storage.delete(key: 'refresh_token');
      return;
    } else {
      throw Exception("${res.body} - ${res.statusCode}");
    }
  }

  @override
  Future<void> refreshToken() async {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final res = await http.post(
      Uri.parse("${url}users/register/"),
      body: jsonEncode({
        "name": name,
        "username": name,
        "email": email,
        "password": password,
      }),
      headers: {
        "Content-Type": "application/json",
      },
    );
    if (res.statusCode == 200) {
      return;
    } else {
      throw Exception("${res.body} - ${res.statusCode}");
    }
  }

  @override
  Future<void> resetPassword({
    required String email,
  }) async {
    final res = await http.post(
      Uri.parse("${url}users/reset_password/"),
      body: jsonEncode({
        "email": email,
      }),
      headers: {
        "Content-Type": "application/json",
      },
    );
    if (res.statusCode == 200) {
      return;
    } else {
      throw Exception("${res.body} - ${res.statusCode}");
    }
  }
}

@riverpod
AuthRepository djangoAuthRepository(DjangoAuthRepositoryRef ref) {
  return DjangoAuthRepository();
}
