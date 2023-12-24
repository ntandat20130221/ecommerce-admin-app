import 'package:ecommerce_admin_app/domain/statistic.dart';
import 'package:ecommerce_admin_app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';

class Stats extends StatefulWidget {
  const Stats({super.key, required this.models});

  final List<Statistic> models;

  @override
  State<Stats> createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      itemCount: 4,
      mainAxisSpacing: defaultPadding,
      crossAxisSpacing: defaultPadding,
      itemBuilder: (context, index) => Container(
        decoration: BoxDecoration(
          color: colorSecondary,
          borderRadius: BorderRadius.circular(defaultPadding / 2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Row(
            children: [
              SvgPicture.asset(
                widget.models[index].icon!,
                height: 32,
                colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
              const SizedBox(width: defaultPadding),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.models[index].title!, style: const TextStyle(fontSize: 12)),
                  const SizedBox(height: 4),
                  Text(widget.models[index].value!, style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
