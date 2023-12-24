import 'package:ecommerce_admin_app/domain/menu.dart';
import 'package:ecommerce_admin_app/presentation/dashboard/dashboard_screen.dart';
import 'package:ecommerce_admin_app/presentation/main/side_menu.dart';
import 'package:ecommerce_admin_app/presentation/orders/orders_screen.dart';
import 'package:ecommerce_admin_app/presentation/products/products_screen.dart';
import 'package:ecommerce_admin_app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.onRouteChanged});

  final void Function() onRouteChanged;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final menus = <Menu>[
    Menu('Dashboard', 'assets/icons/ic_dashboard.svg', isSelected: true),
    Menu('Products', 'assets/icons/ic_product.svg'),
    Menu('Orders', 'assets/icons/ic_order.svg'),
    Menu('Sign out', 'assets/icons/ic_log_out.svg'),
  ];

  Widget? currentFragment = const DashboardScreen();
  var title = 'Dashboard';

  void onMenuTap(Menu selectedMenu) {
    setState(() {
      for (var menu in menus) {
        menu.isSelected = menu.title == selectedMenu.title;
      }
      switch (selectedMenu.title) {
        case 'Dashboard':
          currentFragment = const DashboardScreen();
        case 'Products':
          currentFragment = const ProductScreen();
        case 'Orders':
          currentFragment = const OrdersScreen();
        case 'Sign out':
          final prefs = SharedPreferences.getInstance();
          prefs.then((value) => value.setBool('IS_SIGNED_IN', false));
          widget.onRouteChanged();
      }
      title = selectedMenu.title!;
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        title: Text(title),
        automaticallyImplyLeading: false,
        toolbarHeight: toolbarHeight,
        leading: IconButton(icon: const Icon(Icons.menu), onPressed: () => scaffoldKey.currentState!.openDrawer()),
        backgroundColor: colorBackground,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: CircleAvatar(radius: 22, child: ClipOval(child: Image.asset('assets/images/profile_pic.jpg'))),
          )
        ],
      ),
      drawer: SideMenu(menus: menus, onMenuTap: onMenuTap),
      body: currentFragment,
    );
  }
}
