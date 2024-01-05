import 'package:ecommerce_admin_app/domain/order.dart';
import 'package:ecommerce_admin_app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class OrdersPieChart extends StatelessWidget {
  const OrdersPieChart(this.orders, {super.key});

  final List<Order> orders;

  @override
  Widget build(BuildContext context) {
    int packaging = 0, shipping = 0, dilivered = 0, canceled = 0;
    for (final order in orders) {
      if (order.statusId == 1) packaging++;
      if (order.statusId == 2) shipping++;
      if (order.statusId == 3) dilivered++;
      if (order.statusId == 4) canceled++;
    }
    int totals = packaging + shipping + dilivered + canceled;
    int packagingRatio = (packaging / (totals) * 100).round();
    int shippingRatio = (shipping / (totals) * 100).round();
    int diliveredRatio = (dilivered / (totals) * 100).round();
    int canceledRatio = (canceled / (totals) * 100).round();

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
              dataSource: [
                _PieData('Packaging', packaging, packagingRatio > 0 ? '$packagingRatio%' : ''),
                _PieData('Shipping', shipping, shippingRatio > 0 ? '$shippingRatio%' : ''),
                _PieData('Dilivered', dilivered, diliveredRatio > 0 ? '$diliveredRatio%' : ''),
                _PieData('Canceled', canceled, canceledRatio > 0 ? '$canceledRatio%' : '')
              ],
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
