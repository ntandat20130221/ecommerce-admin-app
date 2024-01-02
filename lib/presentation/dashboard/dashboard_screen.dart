import 'package:ecommerce_admin_app/domain/statistic.dart';
import 'package:ecommerce_admin_app/presentation/dashboard/orders_pie_chart.dart';
import 'package:ecommerce_admin_app/presentation/dashboard/stats.dart';
import 'package:ecommerce_admin_app/shared/constants.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final statistics = [
    Statistic(title: 'Revenue', value: '593434M', icon: 'assets/icons/ic_dollar.svg'),
    Statistic(title: 'Products', value: '7234324', icon: 'assets/icons/ic_products.svg'),
    Statistic(title: 'Orders', value: '234415', icon: 'assets/icons/ic_orders.svg'),
    Statistic(title: 'Customers', value: '25452', icon: 'assets/icons/ic_users.svg'),
  ];
  final isLoading = false;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stats(models: statistics),
                  const SizedBox(height: defaultPadding),
                  const OrdersPieChart(),
                  const SizedBox(height: defaultPadding),
                  const OrdersPieChart(),
                ],
              ),
            ),
          );
  }
}
