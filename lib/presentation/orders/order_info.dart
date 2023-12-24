import 'package:ecommerce_admin_app/domain/order.dart';
import 'package:ecommerce_admin_app/shared/constants.dart';
import 'package:flutter/material.dart';

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
                  const Expanded(flex: 6, child: Text('#1')),
                ],
              ),
              const SizedBox(height: defaultPadding / 2),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 4, child: Text('Order Date', style: TextStyle(color: Colors.green.shade500))),
                  const Expanded(flex: 6, child: Text('23/12/2023')),
                ],
              ),
              const SizedBox(height: defaultPadding / 2),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 4, child: Text('Status', style: TextStyle(color: Colors.green.shade500))),
                  const Expanded(flex: 6, child: Text('Dilivered')),
                ],
              ),
              const SizedBox(height: defaultPadding / 2),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 4, child: Text('Total Price', style: TextStyle(color: Colors.green.shade500))),
                  const Expanded(flex: 6, child: Text('12008 VNĐ')),
                ],
              ),
              const SizedBox(height: defaultPadding / 2),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 4, child: Text('Address', style: TextStyle(color: Colors.green.shade500))),
                  const Expanded(flex: 6, child: Text('23 Quang Trung Street, District 1, Ho Chi Minh City')),
                ],
              ),
            ],
          ),
        )
      ]),
    );
  }
}
