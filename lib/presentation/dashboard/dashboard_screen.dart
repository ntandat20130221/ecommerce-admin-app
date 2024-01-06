import 'package:ecommerce_admin_app/data/repositories/order_repository.dart';
import 'package:ecommerce_admin_app/data/repositories/order_repository_impl.dart';
import 'package:ecommerce_admin_app/data/repositories/product_repository.dart';
import 'package:ecommerce_admin_app/data/repositories/product_repository_impl.dart';
import 'package:ecommerce_admin_app/data/repositories/user_repository.dart';
import 'package:ecommerce_admin_app/data/repositories/user_repository_impl.dart';
import 'package:ecommerce_admin_app/domain/order_status_statistic.dart';
import 'package:ecommerce_admin_app/domain/statistic.dart';
import 'package:ecommerce_admin_app/presentation/dashboard/orders_pie_chart.dart';
import 'package:ecommerce_admin_app/presentation/dashboard/revenue_spark_bar.dart';
import 'package:ecommerce_admin_app/presentation/dashboard/stats.dart';
import 'package:ecommerce_admin_app/shared/constants.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final UserRepository userRepository = UserRepositoryImpl();
  final ProductRepository productRepository = ProductRepositoryImpl();
  final OrderRepository orderRepository = OrderRepositoryImpl();

  final statistics = <Statistic>[];
  final List<OrderStatusStatistic> orderStatusStatistics = [];
  final Map<String, double> revenueData = {};
  var isLoading = true;

  void loadData() async {
    setState(() => isLoading = true);
    final statictisResponses = await Future.wait([
      orderRepository.getTotalRevenue(),
      orderRepository.getOrdersAmount(),
      productRepository.getProductsAmount(),
      userRepository.getUsersAmount(),
    ]);

    final orderStatusStatistics = await orderRepository.getOrderStatusStatistics();
    final revenueData = await orderRepository.getLast12Revenue();

    setState(() {
      statistics.addAll([
        Statistic(
          title: 'Revenue',
          value: '${statictisResponses[0]}M',
          icon: 'assets/icons/ic_dollar.svg',
        ),
        Statistic(
          title: 'Orders',
          value: '${statictisResponses[1]}',
          icon: 'assets/icons/ic_orders.svg',
        ),
        Statistic(
          title: 'Products',
          value: '${statictisResponses[2]}',
          icon: 'assets/icons/ic_products.svg',
        ),
        Statistic(
          title: 'Customers',
          value: '${statictisResponses[3]}',
          icon: 'assets/icons/ic_users.svg',
        ),
      ]);
      this.orderStatusStatistics.addAll(orderStatusStatistics);
      this.revenueData.addAll(revenueData);
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

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
                  OrdersPieChart(orderStatusStatistics),
                  const SizedBox(height: defaultPadding),
                  RevenueSparkBar(data: revenueData),
                ],
              ),
            ),
          );
  }
}
