import 'package:ecommerce_admin_app/domain/order_item.dart';

class Order {
  Order({this.orderId, this.toPhone, this.totalPrice, this.orderDate, this.statusId, this.shippingAddress, this.orderItems});

  int? orderId;
  String? toPhone;
  double? totalPrice;
  DateTime? orderDate;
  int? statusId;
  String? shippingAddress;
  List<OrderItem>? orderItems;

  Order.fromJson(Map<String, dynamic> json)
      : orderId = json['id'],
        toPhone = json['toPhone'],
        totalPrice = json['totalPrice'],
        orderDate = DateTime.parse(json['orderDate']),
        statusId = json['statusId'],
        shippingAddress = json['address'],
        orderItems = (json['orderItems'] as List).map((orderItemJson) => OrderItem.fromJson(orderItemJson)).toList();
}
