import 'package:ecommerce_admin_app/presentation/auth/sign_in_screen.dart';
import 'package:ecommerce_admin_app/presentation/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppRouter extends StatefulWidget {
  const AppRouter({super.key});

  @override
  State<AppRouter> createState() => _AppRouterState();
}

class _AppRouterState extends State<AppRouter> {
  var isSignedIn = false;

  void updateRoute() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() => isSignedIn = prefs.getBool('IS_SIGNED_IN') ?? false);
  }

  @override
  void initState() {
    super.initState();
    updateRoute();
  }

  @override
  Widget build(BuildContext context) {
    return isSignedIn ? MainScreen(onRouteChanged: updateRoute) : SignInScreen(onSignedIn: updateRoute);
  }
}
