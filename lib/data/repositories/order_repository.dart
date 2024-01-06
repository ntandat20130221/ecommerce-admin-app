import 'package:ecommerce_admin_app/domain/order.dart';
import 'package:ecommerce_admin_app/domain/order_status_statistic.dart';

abstract class OrderRepository {
  Future<int> getTotalRevenue();
  Future<int> getOrdersAmount();
  Future<List<Order>> getOrders([int page, int size]);
  Future<bool> updateOrderStatus(int orderId, int status);
  Future<List<OrderStatusStatistic>> getOrderStatusStatistics();
  Future<Map<String, double>> getLast12Revenue();
}
