import 'package:ecommerce_admin_app/domain/order.dart';
import 'package:ecommerce_admin_app/shared/constants.dart';
import 'package:flutter/material.dart';

class OrderItem extends StatelessWidget {
  const OrderItem(this.order, {super.key});

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: colorSecondary, borderRadius: BorderRadius.circular(defaultPadding / 2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: defaultPadding),
            child: Text('Order Items', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
          ),
          const Divider(height: 0, color: Color.fromARGB(255, 54, 58, 80)),
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              children: [
                for (final (index, orderItem) in order.orderItems!.indexed)
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: SizedBox.fromSize(
                              size: const Size.fromRadius(38),
                              child: Image.network(orderItem.product!.imagePaths[0].path, fit: BoxFit.cover),
                            ),
                          ),
                          const SizedBox(width: defaultPadding),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(orderItem.product!.name),
                                const SizedBox(height: defaultPadding / 2),
                                Text('X${orderItem.quantity}'),
                                const SizedBox(height: defaultPadding / 2),
                                Text('${orderItem.totalPrice} VNĐ', style: TextStyle(color: Colors.red.shade500)),
                              ],
                            ),
                          )
                        ],
                      ),
                      index < order.orderItems!.length - 1 ? const SizedBox(height: defaultPadding) : const SizedBox.shrink()
                    ],
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}
