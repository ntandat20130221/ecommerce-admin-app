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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('assets/images/sample_product.jpeg', height: 72),
                    const SizedBox(width: defaultPadding),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Manchester United Jersey'),
                          const SizedBox(height: defaultPadding / 2),
                          const Text('X3'),
                          const SizedBox(height: defaultPadding / 2),
                          Text('109.000 VNĐ', style: TextStyle(color: Colors.red.shade500)),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: defaultPadding),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('assets/images/sample_product.jpeg', height: 72),
                    const SizedBox(width: defaultPadding),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Manchester United Jersey'),
                          const SizedBox(height: defaultPadding / 2),
                          const Text('X3'),
                          const SizedBox(height: defaultPadding / 2),
                          Text('109.000 VNĐ', style: TextStyle(color: Colors.red.shade500)),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: defaultPadding),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('assets/images/sample_product.jpeg', height: 72),
                    const SizedBox(width: defaultPadding),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Manchester United Jersey'),
                          const SizedBox(height: defaultPadding / 2),
                          const Text('X3'),
                          const SizedBox(height: defaultPadding / 2),
                          Text('109.000 VNĐ', style: TextStyle(color: Colors.red.shade500)),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
