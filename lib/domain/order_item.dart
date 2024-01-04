import 'package:ecommerce_admin_app/domain/product.dart';

class OrderItem {
  OrderItem({required this.product, required this.size, required this.quantity, required this.totalPrice});

  Product? product;
  String? size;
  int? quantity;
  double? totalPrice;

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'product': Map<String, dynamic> productJson,
        'size': String size,
        'quantity': int quantity,
        'totalPrice': double totalPrice,
      } =>
        OrderItem(
          product: Product.fromJson(productJson),
          size: size,
          quantity: quantity,
          totalPrice: totalPrice,
        ),
      _ => throw const FormatException('Failed to load orderItem.'),
    };
  }
}
