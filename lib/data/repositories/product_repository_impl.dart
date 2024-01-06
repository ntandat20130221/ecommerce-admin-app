import 'dart:convert';
import 'dart:io';

import 'package:ecommerce_admin_app/data/constants.dart';
import 'package:ecommerce_admin_app/data/repositories/product_repository.dart';
import 'package:ecommerce_admin_app/domain/product.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';

class ProductRepositoryImpl implements ProductRepository {
  @override
  Future<int> getProductsAmount() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/admin/products-amount'));
      if (response.statusCode == 200) {
        return int.parse(response.body);
      }
      return 0;
    } catch (_) {
      return 0;
    }
  }

  @override
  Future<List<Product>> getProducts([int? page, int? size]) async {
    try {
      final products = <Product>[];
      final response = await http.get(Uri.parse('$baseUrl/api/admin/products?page=$page&size=$size'));
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
  Future<bool> createProduct(Product product, List<dynamic> images) async {
    final request = http.MultipartRequest('POST', Uri.parse('$baseUrl/api/products'));
    await _buildRequest(request, product, images);
    final response = await request.send();
    return response.statusCode == 200;
  }

  @override
  Future<bool> updateProduct(Product product, List<dynamic> images) async {
    final request = http.MultipartRequest('PUT', Uri.parse('$baseUrl/api/products'));
    await _buildRequest(request, product, images);
    final response = await request.send();
    return response.statusCode == 200;
  }

  Future<void> _buildRequest(MultipartRequest request, Product product, List<dynamic> images) async {
    request.files.add(http.MultipartFile.fromString('product', jsonEncode(product.toJson()), contentType: MediaType('application', 'json')));
    final mutipartFiles = <http.MultipartFile>[];
    for (final image in images) {
      final mutipartFile = image is String
          ? http.MultipartFile.fromBytes('images', (await http.get(Uri.parse(image))).bodyBytes, filename: image)
          : await http.MultipartFile.fromPath('images', (image as File).path);
      mutipartFiles.add(mutipartFile);
    }
    request.files.addAll(mutipartFiles);
  }

  @override
  Future<bool> deleteProduct(Product product) async {
    final response = await http.delete(Uri.parse('$baseUrl/api/product/${product.id}'));
    return response.statusCode == 200;
  }
}
