import 'package:ecommerce_admin_app/data/repositories/order_repository.dart';
import 'package:ecommerce_admin_app/data/repositories/order_repository_impl.dart';
import 'package:ecommerce_admin_app/data/repositories/product_repository.dart';
import 'package:ecommerce_admin_app/data/repositories/product_repository_impl.dart';
import 'package:ecommerce_admin_app/data/repositories/user_repository.dart';
import 'package:ecommerce_admin_app/data/repositories/user_repository_impl.dart';
import 'package:ecommerce_admin_app/domain/order.dart';
import 'package:ecommerce_admin_app/domain/product.dart';
import 'package:ecommerce_admin_app/domain/statistic.dart';
import 'package:ecommerce_admin_app/domain/user.dart';
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

  late List<Order> orders;
  late List<Product> products;
  late List<User> users;

  final statistics = <Statistic>[];
  final Map<String, double> revenueData = {};
  var isLoading = true;

  void loadData() async {
    setState(() => isLoading = true);
    final responses = await Future.wait([
      orderRepository.getOrders(),
      productRepository.getProducts(),
      userRepository.getUsers(),
    ]);

    orders = List<Order>.from(responses[0]);
    products = List<Product>.from(responses[1]);
    users = List<User>.from(responses[2]);

    // Load revenue data.
    final revenueData = await orderRepository.getLast12Revenue();

    setState(() {
      statistics.addAll([
        Statistic(
          title: 'Revenue',
          value: '${orders.fold(0, (value, element) => element.totalPrice!.toInt() + value)}M',
          icon: 'assets/icons/ic_dollar.svg',
        ),
        Statistic(
          title: 'Products',
          value: '${products.length}',
          icon: 'assets/icons/ic_products.svg',
        ),
        Statistic(
          title: 'Orders',
          value: '${orders.length}',
          icon: 'assets/icons/ic_orders.svg',
        ),
        Statistic(
          title: 'Customers',
          value: '${users.length}',
          icon: 'assets/icons/ic_users.svg',
        ),
      ]);
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
                  OrdersPieChart(orders),
                  const SizedBox(height: defaultPadding),
                  RevenueSparkBar(data: revenueData),
                ],
              ),
            ),
          );
  }
}
