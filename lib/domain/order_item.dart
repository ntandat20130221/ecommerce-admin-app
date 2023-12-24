import 'package:ecommerce_admin_app/domain/product.dart';

class OrderItem {
  OrderItem({this.product, this.quantity});

  Product? product;
  int? quantity;
}
