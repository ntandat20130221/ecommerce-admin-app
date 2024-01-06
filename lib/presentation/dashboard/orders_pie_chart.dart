import 'package:ecommerce_admin_app/domain/order_status_statistic.dart';
import 'package:ecommerce_admin_app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class OrdersPieChart extends StatelessWidget {
  const OrdersPieChart(this.orderStatusStatistics, {super.key});

  final List<OrderStatusStatistic> orderStatusStatistics;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(defaultPadding / 2),
        color: colorSecondary,
      ),
      child: SfCircularChart(
        title: const ChartTitle(text: 'Orders Status', alignment: ChartAlignment.near, textStyle: TextStyle(fontSize: 14)),
        legend: const Legend(isVisible: true, position: LegendPosition.bottom, overflowMode: LegendItemOverflowMode.scroll),
        series: <DoughnutSeries<_PieData, String>>[
          DoughnutSeries<_PieData, String>(
              explode: true,
              explodeIndex: 0,
              dataSource: orderStatusStatistics.map((e) => _PieData(e.name!, e.percentage!, '${e.percentage!.round()}%')).toList(),
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
