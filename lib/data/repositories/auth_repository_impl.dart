import 'dart:convert';

import 'package:ecommerce_admin_app/data/constants.dart';
import 'package:ecommerce_admin_app/data/repositories/auth_repository.dart';
import 'package:ecommerce_admin_app/domain/admin.dart';
import 'package:http/http.dart' as http;

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<Admin?> signUp(String email, String password) async {
    final response = await http.post(
      headers: {'Content-Type': 'application/json'},
      Uri.parse('$baseUrl/api/admin/sign_up'),
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return Admin.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  @override
  Future<Admin?> signIn(String email, String password) async {
    final response = await http.post(
      headers: {'Content-Type': 'application/json'},
      Uri.parse('$baseUrl/api/admin/sign_in'),
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return Admin.fromJson(jsonDecode(response.body));
    }
    return null;
  }
}
