import 'package:ecommerce_admin_app/domain/order.dart';

abstract class OrderRepository {
  Future<List<Order>> getOrders();
  Future<bool> updateOrderStatus(int orderId, int status);
}