import 'package:ecommerce_admin_app/domain/order_item.dart';
import 'package:ecommerce_admin_app/domain/user.dart';

class Order {
  Order({this.orderId, this.user, this.totalPrice, this.orderDate, this.statusId, this.shippingAddress, this.orderItems});

  int? orderId;
  User? user;
  double? totalPrice;
  DateTime? orderDate;
  int? statusId;
  String? shippingAddress;
  List<OrderItem>? orderItems;

  Order.fromJson(Map<String, dynamic> json)
      : orderId = json['id'],
        user = User.fromJson(json['user']),
        totalPrice = json['totalPrice'],
        orderDate = DateTime.parse(json['orderDate']),
        statusId = json['statusId'],
        shippingAddress = json['address'],
        orderItems = (json['orderItems'] as List).map((orderItemJson) => OrderItem.fromJson(orderItemJson)).toList();
}
