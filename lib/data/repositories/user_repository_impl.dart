import 'package:ecommerce_admin_app/data/constants.dart';
import 'package:ecommerce_admin_app/data/repositories/user_repository.dart';
import 'package:http/http.dart' as http;

class UserRepositoryImpl implements UserRepository {
  @override
  Future<int> getUsersAmount() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/admin/users-amount'));
      if (response.statusCode == 200) {
        return int.parse(response.body);
      }
      return 0;
    } catch (_) {
      return 0;
    }
  }
}
