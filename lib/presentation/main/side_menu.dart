import 'package:ecommerce_admin_app/domain/menu.dart';
import 'package:ecommerce_admin_app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key, required this.menus, required this.onMenuTap});

  final List<Menu> menus;
  final void Function(Menu) onMenuTap;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: colorBackground,
        child: Material(
          color: Colors.transparent,
          child: ListView(
            children: [
              DrawerHeader(child: Image.asset('assets/images/logo.png')),
              DrawerListTiles(menus, onMenuTap: onMenuTap),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerListTiles extends StatelessWidget {
  const DrawerListTiles(this.menus, {super.key, required this.onMenuTap});

  final List<Menu> menus;
  final void Function(Menu) onMenuTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final menu in menus)
          InkWell(
            child: Container(
              color: menu.isSelected ? colorSecondary : null,
              child: ListTile(
                onTap: () => onMenuTap(menu),
                leading: SvgPicture.asset(menu.icon!, colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn), height: 20),
                title: Text(menu.title!, style: const TextStyle(color: Color.fromARGB(255, 218, 218, 218))),
              ),
            ),
          )
      ],
    );
  }
}
