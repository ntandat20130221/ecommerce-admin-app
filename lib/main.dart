import 'package:ecommerce_admin_app/app_router.dart';
import 'package:ecommerce_admin_app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ecommerce Admin App',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: colorBackground,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme).apply(bodyColor: Colors.white),
        canvasColor: colorSecondary,
      ),
      home: const AppRouter(),
    );
  }
}
