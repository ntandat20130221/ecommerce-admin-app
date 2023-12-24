import 'package:ecommerce_admin_app/domain/order.dart';
import 'package:ecommerce_admin_app/presentation/orders/order_info.dart';
import 'package:ecommerce_admin_app/presentation/orders/order_item.dart';
import 'package:ecommerce_admin_app/shared/constants.dart';
import 'package:flutter/material.dart';

class OrderDetail extends StatelessWidget {
  const OrderDetail(this.order, {super.key});

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Detail'),
        automaticallyImplyLeading: false,
        toolbarHeight: toolbarHeight,
        leading: IconButton(icon: const Icon(Icons.arrow_back_rounded), onPressed: () => Navigator.of(context).pop()),
        backgroundColor: colorBackground,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        child: ListView(
          children: [
            const SizedBox(height: defaultPadding),
            OrderInfo(order),
            const SizedBox(height: 20),
            OrderItem(order),
          ],
        ),
      ),
    );
  }
}
