import 'package:ecommerce_admin_app/domain/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();
}