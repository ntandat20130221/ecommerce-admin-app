import 'dart:async';

import 'package:ecommerce_admin_app/data/repositories/order_repository.dart';
import 'package:ecommerce_admin_app/data/repositories/order_repository_impl.dart';
import 'package:ecommerce_admin_app/domain/order.dart';
import 'package:ecommerce_admin_app/presentation/orders/order_detail.dart';
import 'package:ecommerce_admin_app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final OrderRepository orderRepository = OrderRepositoryImpl();

  final streamController = StreamController<List<Order>>();

  void refreshData() {
    streamController.addStream(orderRepository.getOrders().asStream());
  }

  @override
  void initState() {
    super.initState();
    refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: streamController.stream,
      builder: (context, snapshot) {
        final orders = snapshot.data;
        return orders != null && orders.isNotEmpty
            ? SingleChildScrollView(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    dataRowMaxHeight: 50,
                    showCheckboxColumn: false,
                    columns: const <DataColumn>[
                      DataColumn(label: Expanded(child: Text('ID', style: TextStyle(fontWeight: FontWeight.bold)))),
                      DataColumn(label: Expanded(child: Text('Date', style: TextStyle(fontWeight: FontWeight.bold)))),
                      DataColumn(label: Expanded(child: Text('Status', style: TextStyle(fontWeight: FontWeight.bold)))),
                      DataColumn(label: Expanded(child: Text('User ID', style: TextStyle(fontWeight: FontWeight.bold)))),
                      DataColumn(label: Expanded(child: Text('Total Prices', style: TextStyle(fontWeight: FontWeight.bold)))),
                      DataColumn(label: Expanded(child: Text('Shipping Address', style: TextStyle(fontWeight: FontWeight.bold)))),
                    ],
                    rows: <DataRow>[
                      for (final order in snapshot.data!)
                        DataRow(
                          onSelectChanged: (_) => Navigator.push(context, MaterialPageRoute(builder: (context) => OrderDetail(order))),
                          cells: <DataCell>[
                            DataCell(Text('#${order.orderId}')),
                            DataCell(Text(DateFormat('yyyy-MM-dd HH:mm:ss').format(order.orderDate!))),
                            DataCell(
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6.0),
                                child: DropdownButton<int>(
                                  borderRadius: BorderRadius.circular(8.0),
                                  padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                                  onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                                  value: order.statusId,
                                  onChanged: (value) async {
                                    await orderRepository.updateOrderStatus(order.orderId!, value!);
                                    refreshData();
                                  },
                                  items: [
                                    DropdownMenuItem(value: 1, child: Text('Packaging', style: TextStyle(color: Colors.amber.shade300))),
                                    DropdownMenuItem(value: 2, child: Text('Shipping', style: TextStyle(color: Colors.blue.shade300))),
                                    DropdownMenuItem(value: 3, child: Text('Dilivered', style: TextStyle(color: Colors.green.shade300))),
                                    DropdownMenuItem(value: 4, child: Text('Canceled', style: TextStyle(color: Colors.red.shade300))),
                                  ],
                                ),
                              ),
                            ),
                            DataCell(Text('#${order.user!.userId}')),
                            DataCell(Text('${order.totalPrice}')),
                            DataCell(Text('${order.shippingAddress}')),
                          ],
                        ),
                    ],
                  ),
                ),
              )
            : const Center(child: CircularProgressIndicator());
      },
    );
  }
}
