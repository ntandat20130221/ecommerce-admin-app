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
              DrawerHeader(
                decoration: const BoxDecoration(border: Border(bottom: BorderSide(width: 0))),
                child: Image.asset('assets/images/logo.png'),
              ),
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                color: menu.isSelected ? colorSecondary : null,
              ),
              child: ListTile(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
                onTap: () => onMenuTap(menu),
                leading: SvgPicture.asset(
                  menu.icon!,
                  colorFilter: ColorFilter.mode(menu.isSelected ? colorPrimary : const Color.fromARGB(255, 221, 221, 221), BlendMode.srcIn),
                  height: 20,
                ),
                title: Text(menu.title!, style: TextStyle(color: menu.isSelected ? colorPrimary : const Color.fromARGB(255, 221, 221, 221))),
              ),
            ),
          )
      ],
    );
  }
}
