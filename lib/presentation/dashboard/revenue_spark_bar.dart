import 'package:ecommerce_admin_app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class RevenueSparkBar extends StatelessWidget {
  const RevenueSparkBar({required this.data, super.key});

  final Map<String, double> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(defaultPadding / 2),
        color: colorSecondary,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Revenue Statistic', style: TextStyle(fontSize: 17.5, color: Colors.white)),
          const SizedBox(height: defaultPadding),
          SfSparkBarChart(
            labelDisplayMode: SparkChartLabelDisplayMode.all,
            axisLineColor: const Color.fromARGB(255, 166, 186, 250),
            trackball: SparkChartTrackball(
                backgroundColor: Colors.red,
                borderColor: Colors.red.withOpacity(0.8),
                borderWidth: 2,
                color: Colors.red,
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                activationMode: SparkChartActivationMode.tap),
            data: [...data.values],
          ),
        ],
      ),
    );
  }
}
