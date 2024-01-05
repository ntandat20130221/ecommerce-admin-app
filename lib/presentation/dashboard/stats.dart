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
      itemCount: widget.models.length,
      mainAxisSpacing: defaultPadding,
      crossAxisSpacing: defaultPadding,
      itemBuilder: (context, index) {
        final model = widget.models[index];
        return Container(
          decoration: BoxDecoration(
            color: colorSecondary,
            borderRadius: BorderRadius.circular(defaultPadding / 2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Row(
              children: [
                SvgPicture.asset(
                  model.icon!,
                  height: 32,
                  width: 32,
                  colorFilter: ColorFilter.mode(
                      model.title == 'Revenue'
                          ? Colors.amber.shade400
                          : model.title == 'Products'
                              ? Colors.red.shade400
                              : model.title == 'Orders'
                                  ? Colors.green.shade400
                                  : Colors.blue.shade400,
                      BlendMode.srcIn),
                ),
                const SizedBox(width: defaultPadding),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(model.title!, style: const TextStyle(fontSize: 12, color: Color.fromARGB(255, 231, 231, 231))),
                    const SizedBox(height: 4),
                    Text(model.value!, style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
