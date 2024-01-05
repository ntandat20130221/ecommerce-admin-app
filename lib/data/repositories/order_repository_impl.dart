import 'dart:convert';

import 'package:ecommerce_admin_app/data/constants.dart';
import 'package:ecommerce_admin_app/data/repositories/order_repository.dart';
import 'package:ecommerce_admin_app/domain/order.dart';
import 'package:http/http.dart' as http;

class OrderRepositoryImpl implements OrderRepository {
  @override
  Future<List<Order>> getOrders() async {
    try {
      final orders = <Order>[];
      final response = await http.get(Uri.parse('$baseUrl/api/admin/orders'));
      if (response.statusCode == 200) {
        final orderJsons = jsonDecode(utf8.decode(response.bodyBytes));
        for (final orderJson in orderJsons) {
          orders.add(Order.fromJson(orderJson));
        }
      }
      return orders;
    } catch (_) {
      return [];
    }
  }

  @override
  Future<bool> updateOrderStatus(int orderId, int status) async {
    final response = await http.patch(
      Uri.parse('$baseUrl/api/admin/order/update-status/$orderId'),
      body: status.toString(),
    );
    return response.statusCode == 200;
  }

  @override
  Future<Map<String, double>> getLast12Revenue() async {
    final response = await http.get(Uri.parse('$baseUrl/api/admin/last-12-revenue'));
    if (response.statusCode == 200) {
      return Map<String, double>.from(jsonDecode(response.body));
    }
    return {};
  }
}
