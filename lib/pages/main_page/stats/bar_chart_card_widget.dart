import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:game_lists/pages/main_page/stats/stats_card_widget.dart';

class BarChartCardData {
  final int x;
  final int y;
  BarChartCardData({
    required this.x,
    required this.y,
  });
}


class BarChartCardWidget extends StatelessWidget {
  final String title;
  final List<BarChartCardData> data;
  final Color color;

  const BarChartCardWidget({
    Key? key,
    required this.title,
    required this.data,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatsCardWidget(
      title: title,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(width: 16),
            Container(
              width: data.length * 35,
              child: AspectRatio(
                aspectRatio: 1,
                child: BarChart(
                  BarChartData(
                    borderData: FlBorderData(
                      show: false,
                    ),
                    maxY: data.map((e) => e.y.round()).toList().reduce(max) + 1,
                    barTouchData: BarTouchData(
                      enabled: false,
                      touchTooltipData: BarTouchTooltipData(
                        tooltipBgColor: Colors.transparent,
                        tooltipPadding: const EdgeInsets.all(0),
                        tooltipMargin: 0,
                        getTooltipItem: (
                          BarChartGroupData group,
                          int groupIndex,
                          BarChartRodData rod,
                          int rodIndex,
                        ) {
                          return BarTooltipItem(
                            rod.y.round().toString(),
                            TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                    ),
                    barGroups: data
                        .map((e) => BarChartGroupData(
                                x: e.x,
                                showingTooltipIndicators: [
                                  0
                                ],
                                barRods: [
                                  BarChartRodData(
                                      colors: [color], y: e.y.toDouble())
                                ]))
                        .toList(),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: SideTitles(
                        showTitles: true,
                        getTextStyles: (value) => const TextStyle(
                            color: Color(0xff8fbcbb),
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                        margin: 20,
                        getTitles: (double value) {
                          return value.round().toString();
                        },
                      ),
                      leftTitles: SideTitles(
                        showTitles: false,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
