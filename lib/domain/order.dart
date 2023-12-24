import 'package:ecommerce_admin_app/domain/address.dart';
import 'package:ecommerce_admin_app/domain/order_item.dart';

class Order {
  Order({this.orderId, this.userId, this.totalPrice, this.orderDate, this.status, this.shippingAddress, this.orderItems});

  String? orderId;
  String? userId;
  double? totalPrice;
  int? orderDate;
  String? status;
  Address? shippingAddress;
  List<OrderItem>? orderItems;
}
