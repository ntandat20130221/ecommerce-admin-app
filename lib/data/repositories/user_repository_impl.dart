import 'dart:convert';

import 'package:ecommerce_admin_app/data/constants.dart';
import 'package:ecommerce_admin_app/data/repositories/user_repository.dart';
import 'package:ecommerce_admin_app/domain/user.dart';
import 'package:http/http.dart' as http;

class UserRepositoryImpl implements UserRepository {
  @override
  Future<List<User>> getUsers() async {
    try {
      final users = <User>[];
      final response = await http.get(Uri.parse('$baseUrl/api/admin/users'));
      if (response.statusCode == 200) {
        for (final userJson in jsonDecode(utf8.decode(response.bodyBytes))) {
          users.add(User.fromJson(userJson));
        }
      }
      return users;
    } catch (_) {
      return [];
    }
  }
}
