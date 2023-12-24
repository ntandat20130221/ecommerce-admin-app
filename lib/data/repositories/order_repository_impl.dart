import 'package:ecommerce_admin_app/data/repositories/order_repository.dart';
import 'package:ecommerce_admin_app/domain/order.dart';

class OrderRepositoryImpl implements OrdeRepository {
  @override
  Future<List<Order>> getOrders() async {
    return List.empty();
  }

  @override
  Future<void> updateOrderStatus(String orderId, String status) async {
    
  }
}
