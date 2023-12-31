import 'package:ecommerce_admin_app/domain/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();
  Future<bool> createProduct(Product product);
  Future<bool> updateProduct(Product product);
  Future<bool> deleteProduct(Product product);
}
