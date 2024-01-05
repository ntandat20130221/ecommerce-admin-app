import 'package:ecommerce_admin_app/domain/user.dart';

abstract class UserRepository {
  Future<List<User>> getUsers();
}
