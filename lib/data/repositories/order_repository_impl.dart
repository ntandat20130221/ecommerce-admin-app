import 'dart:convert';

import 'package:ecommerce_admin_app/data/constants.dart';
import 'package:ecommerce_admin_app/data/repositories/order_repository.dart';
import 'package:ecommerce_admin_app/domain/order.dart';
import 'package:ecommerce_admin_app/domain/order_status_statistic.dart';
import 'package:http/http.dart' as http;

class OrderRepositoryImpl implements OrderRepository {
  @override
  Future<int> getTotalRevenue() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/admin/total-revenue'));
      if (response.statusCode == 200) {
        return int.parse(response.body);
      }
      return 0;
    } catch (_) {
      return 0;
    }
  }

  @override
  Future<int> getOrdersAmount() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/admin/orders-amount'));
      if (response.statusCode == 200) {
        return int.parse(response.body);
      }
      return 0;
    } catch (_) {
      return 0;
    }
  }

  @override
  Future<List<Order>> getOrders([int? page, int? size]) async {
    try {
      final orders = <Order>[];
      final response = await http.get(Uri.parse('$baseUrl/api/admin/orders?page=$page&size=$size'));
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
  Future<List<OrderStatusStatistic>> getOrderStatusStatistics() async {
    final orderStatusStatistic = <OrderStatusStatistic>[];
    final response = await http.get(Uri.parse('$baseUrl/api/admin/order-status-statistics'));
    if (response.statusCode == 200) {
      for (final json in jsonDecode(response.body)) {
        orderStatusStatistic.add(OrderStatusStatistic.fromJson(json));
      }
      return orderStatusStatistic;
    }
    return [];
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
