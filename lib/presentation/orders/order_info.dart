import 'package:ecommerce_admin_app/domain/order.dart';
import 'package:ecommerce_admin_app/shared/constants.dart';
import 'package:flutter/material.dart';

final orderStatusMap = {
  1: 'Packaging',
  2: 'Shipping',
  3: 'Diliverd',
  4: 'Canceled',
};

class OrderInfo extends StatelessWidget {
  const OrderInfo(this.order, {super.key});

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: colorSecondary, borderRadius: BorderRadius.circular(defaultPadding / 2)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 14, horizontal: defaultPadding),
          child: Text('Order Information', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
        ),
        const Divider(height: 0, color: Color.fromARGB(255, 54, 58, 80)),
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 4, child: Text('Order ID', style: TextStyle(color: Colors.green.shade500))),
                  Expanded(flex: 6, child: Text('#${order.orderId}')),
                ],
              ),
              const SizedBox(height: defaultPadding / 2 + 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 4, child: Text('User Phone', style: TextStyle(color: Colors.green.shade500))),
                  Expanded(flex: 6, child: Text('${order.toPhone}')),
                ],
              ),
              const SizedBox(height: defaultPadding / 2 + 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 4, child: Text('Order Date', style: TextStyle(color: Colors.green.shade500))),
                  Expanded(flex: 6, child: Text('${order.orderDate}')),
                ],
              ),
              const SizedBox(height: defaultPadding / 2 + 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 4, child: Text('Status', style: TextStyle(color: Colors.green.shade500))),
                  Expanded(
                    flex: 6,
                    child: UnconstrainedBox(
                      alignment: Alignment.topLeft,
                      child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                          decoration: BoxDecoration(
                              color: order.statusId == 1
                                  ? Colors.amber.shade400
                                  : order.statusId == 2
                                      ? Colors.blue.shade400
                                      : order.statusId == 3
                                          ? Colors.green.shade400
                                          : Colors.red.shade400,
                              borderRadius: BorderRadius.circular(4.0)),
                          child: Text('${orderStatusMap[order.statusId]}')),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: defaultPadding / 2 + 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 4, child: Text('Total Price', style: TextStyle(color: Colors.green.shade500))),
                  Expanded(flex: 6, child: Text('${order.totalPrice} VNĐ')),
                ],
              ),
              const SizedBox(height: defaultPadding / 2 + 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 4, child: Text('Address', style: TextStyle(color: Colors.green.shade500))),
                  Expanded(flex: 6, child: Text('${order.shippingAddress}')),
                ],
              ),
            ],
          ),
        )
      ]),
    );
  }
}
