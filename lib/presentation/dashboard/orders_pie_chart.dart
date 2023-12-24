import 'package:ecommerce_admin_app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class OrdersPieChart extends StatelessWidget {
  const OrdersPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(defaultPadding / 2),
        color: colorSecondary,
      ),
      child: SfCircularChart(
        title: const ChartTitle(text: 'Orders Status', alignment: ChartAlignment.near, textStyle: TextStyle(fontSize: 12)),
        legend: const Legend(isVisible: true),
        series: <PieSeries<_PieData, String>>[
          PieSeries<_PieData, String>(
              explode: true,
              explodeIndex: 0,
              dataSource: [_PieData('3dsfdsf', 10, 'Text'), _PieData('3', 15, 'Text'), _PieData('3', 8, 'Text')],
              xValueMapper: (_PieData data, _) => data.xData,
              yValueMapper: (_PieData data, _) => data.yData,
              dataLabelMapper: (_PieData data, _) => data.text,
              dataLabelSettings: const DataLabelSettings(isVisible: true)),
        ],
      ),
    );
  }
}

class _PieData {
  _PieData(this.xData, this.yData, [this.text]);
  final String xData;
  final num yData;
  String? text;
}
