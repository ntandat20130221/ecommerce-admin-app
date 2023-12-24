import 'package:ecommerce_admin_app/domain/order.dart';
import 'package:ecommerce_admin_app/presentation/orders/order_detail.dart';
import 'package:ecommerce_admin_app/shared/constants.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var isLoading = false;
  var dropDownValue = 'one';

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                dataRowMaxHeight: 50,
                showCheckboxColumn: false,
                columns: const <DataColumn>[
                  DataColumn(label: Expanded(child: Text('ID', style: TextStyle(fontWeight: FontWeight.bold)))),
                  DataColumn(label: Expanded(child: Text('Date', style: TextStyle(fontWeight: FontWeight.bold)))),
                  DataColumn(label: Expanded(child: Text('Status', style: TextStyle(fontWeight: FontWeight.bold)))),
                  DataColumn(label: Expanded(child: Text('Total Prices', style: TextStyle(fontWeight: FontWeight.bold)))),
                  DataColumn(label: Expanded(child: Text('Shipping Address', style: TextStyle(fontWeight: FontWeight.bold)))),
                ],
                rows: <DataRow>[
                  for (var i = 0; i < 20; i++)
                    DataRow(
                      onSelectChanged: (_) => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrderDetail(Order(orderDate: 482343924, orderId: 'sfdsf', orderItems: List.empty())))),
                      cells: <DataCell>[
                        const DataCell(Text('#0')),
                        const DataCell(Text('23/12/2023')),
                        DataCell(
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: DropdownButton<String>(
                              borderRadius: BorderRadius.circular(8.0),
                              padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                              value: dropDownValue,
                              onChanged: (value) => setState(() => dropDownValue = value ?? 'one'),
                              items: [
                                DropdownMenuItem(value: 'one', child: Text('Dilivered', style: TextStyle(color: Colors.green.shade200))),
                                DropdownMenuItem(value: 'two', child: Text('Shipping', style: TextStyle(color: Colors.blue.shade200))),
                                DropdownMenuItem(value: 'three', child: Text('Canceled', style: TextStyle(color: Colors.red.shade200))),
                              ],
                            ),
                          ),
                        ),
                        const DataCell(Text('128008 VNĐ')),
                        const DataCell(Text('23 Quang Trung Street, District 1, Ho Chi Minh City')),
                      ],
                    ),
                ],
              ),
            ),
          );
  }
}
