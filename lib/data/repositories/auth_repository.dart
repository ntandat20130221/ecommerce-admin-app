import 'package:ecommerce_admin_app/domain/admin.dart';

abstract class AuthRepository {
  Future<Admin?> signUp(String email, String password);
  Future<Admin?> signIn(String email, String password);
}
