import 'package:ecommerce_admin_app/domain/product.dart';

abstract class ProductRepository {
  Future<int> getProductsAmount();
  Future<List<Product>> getProducts([int? page, int? size]);
  Future<bool> createProduct(Product product, List<dynamic> images);
  Future<bool> updateProduct(Product product, List<dynamic> images);
  Future<bool> deleteProduct(Product product);
}
