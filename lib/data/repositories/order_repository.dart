import 'package:ecommerce_admin_app/domain/order.dart';

abstract class OrdeRepository {
  Future<List<Order>> getOrders();
  Future<void> updateOrderStatus(String orderId, String status);
}