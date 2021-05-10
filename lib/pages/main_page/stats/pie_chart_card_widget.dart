import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:game_lists/pages/main_page/stats/stats_card_widget.dart';

class ChartLegendElementWidget extends StatelessWidget {
  final PieChartCardData data;

  const ChartLegendElementWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatElementWidget(
      title: data.title,
      value: data.value.toString(),
      color: data.color,
    );
  }
}

class PieChartCardData {
  final String title;
  final int value;
  final Color color;
  final bool isHide;
  PieChartCardData({
    required this.title,
    required this.value,
    required this.color,
    bool? isHide,
  }) : this.isHide = isHide ?? false;
}

class PieChartCardWidget extends StatelessWidget {
  final String title;
  final List<PieChartCardData> data;

  const PieChartCardWidget({
    Key? key,
    required this.title,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatsCardWidget(
      title: title,
      child: AspectRatio(
        aspectRatio: 5 / 3,
        child: PieChart(PieChartData(
          centerSpaceRadius: 0,
          sections: data
              .where((element) => element.isHide != true)
              .map((e) => PieChartSectionData(
                    title: e.value.toString(),
                    color: e.color,
                    value: e.value.toDouble(),
                    radius: 100,
                    titleStyle: TextStyle(
                      fontSize: 16,
                      color: const Color(0xffffffff),
                    ),
                  ))
              .toList(),
        )),
      ),
      children: data.map((e) => ChartLegendElementWidget(data: e)).toList(),
    );
  }
}
