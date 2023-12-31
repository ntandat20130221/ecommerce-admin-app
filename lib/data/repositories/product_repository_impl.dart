import 'dart:convert';

import 'package:ecommerce_admin_app/data/constants.dart';
import 'package:ecommerce_admin_app/data/repositories/product_repository.dart';
import 'package:ecommerce_admin_app/domain/image_path.dart';
import 'package:ecommerce_admin_app/domain/product.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ProductRepositoryImpl implements ProductRepository {
  @override
  Future<List<Product>> getProducts() async {
    try {
      final products = <Product>[];
      final response = await http.get(Uri.parse('$baseUrl/api/admin/products'));
      if (response.statusCode == 200) {
        final productJsons = jsonDecode(utf8.decode(response.bodyBytes));
        for (final productJson in productJsons) {
          products.add(Product.fromJson(productJson));
        }
      }
      return products;
    } catch (_) {
      return [];
    }
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
    for (final imagePath in product.imagePaths) {
      final mutipartFile = await http.MultipartFile.fromPath('images', imagePath.path);
      mutipartFiles.add(mutipartFile);
    }
    request.files.addAll(mutipartFiles);

    final response = await request.send();
    return response.statusCode == 200;
  }

  @override
  Future<bool> updateProduct(Product product) async {
    final request = http.MultipartRequest('PUT', Uri.parse('$baseUrl/api/products'));
    request.files.add(http.MultipartFile.fromString(
      'product',
      jsonEncode(product.toJson()),
      contentType: MediaType('application', 'json'),
    ));

    for (final imagePath in product.imagePaths) {
      http.MultipartFile mutipartFile;
      if (imagePath.from == From.local) {
        mutipartFile = await http.MultipartFile.fromPath('images', imagePath.path);
      } else {
        mutipartFile = http.MultipartFile.fromString('remainImages', imagePath.path);
      }
      request.files.add(mutipartFile);
    }

    final response = await request.send();
    return response.statusCode == 200;
  }
}
