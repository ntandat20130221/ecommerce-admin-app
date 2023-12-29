import 'dart:convert';

import 'package:ecommerce_admin_app/data/constants.dart';
import 'package:ecommerce_admin_app/data/repositories/product_repository.dart';
import 'package:ecommerce_admin_app/domain/product.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ProductRepositoryImpl implements ProductRepository {
  @override
  Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/api/admin/products'));
    final products = <Product>[];
    if (response.statusCode == 200) {
      final productJsons = jsonDecode(utf8.decode(response.bodyBytes));
      for (final productJson in productJsons) {
        products.add(Product.fromJson(productJson));
      }
    }
    return products;
  }

  @override
  Future<bool> createProduct(Product product) async {
    final request = http.MultipartRequest('POST', Uri.parse('$baseUrl/api/products'));
    request.files.add(http.MultipartFile.fromString(
      'product',
      jsonEncode(product.toJson()),
      contentType: MediaType('application', 'json'),
    ));

    final mutipartFiles = <http.MultipartFile>[];
    for (final path in product.images) {
      final mutipartFile = await http.MultipartFile.fromPath('images', path);
      mutipartFiles.add(mutipartFile);
    }
    request.files.addAll(mutipartFiles);

    final response = await request.send();
    return response.statusCode == 200;
  }
}
