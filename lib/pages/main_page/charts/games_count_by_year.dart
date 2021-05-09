import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:game_lists/model/game.dart';
import 'package:game_lists/model/status.dart';
import 'package:hive/hive.dart';

class CompletedGamesCountByFinishYear extends StatefulWidget {
  @override
  _CompletedGamesCountByFinishYearState createState() =>
      _CompletedGamesCountByFinishYearState();
}

class _CompletedGamesCountByFinishYearState
    extends State<CompletedGamesCountByFinishYear> {
  Future<List<BarChartGroupData>> _getData() async {
    var gameBox = await Hive.openBox<Game>('game');
    var games = gameBox.values
        .where((element) => element.status == Status.completed)
        .toList();
    var years = <int>{};
    for (var game in games) {
      for (var walkthrough in game.walkthroughs) {
        if (walkthrough.endDate != null) {
          years.add(walkthrough.endDate!.year);
        }
      }
    }
    var data = <BarChartGroupData>[];
    for (var year in years) {
      int count = 0;
      for (var game in games) {
        for (var walkthrough in game.walkthroughs) {
          if (walkthrough.endDate != null &&
              walkthrough.endDate!.year == year) {
            count++;
          }
        }
      }
      data.add(
        BarChartGroupData(
          x: year,
          showingTooltipIndicators: [0],
          barRods: [
            BarChartRodData(colors: [Color(0xffbf616a)], y: count.toDouble())
          ],
        ),
      );
    }
    data.sort((a, b) => a.x.compareTo(b.x));
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BarChartGroupData>>(
        future: _getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data!;
            return Card(
              margin: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      'Completed Games Count By Finish Year',
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    GamesCountByYear(data: data),
                  ],
                ),
              ),
            );
          }
          return Container();
        });
  }
}

class CompletedGamesCountByReleaseYear extends StatefulWidget {
  @override
  _CompletedGamesCountByReleaseYearState createState() =>
      _CompletedGamesCountByReleaseYearState();
}

class _CompletedGamesCountByReleaseYearState
    extends State<CompletedGamesCountByReleaseYear> {
  Future<List<BarChartGroupData>> _getGameCountByGameStatus() async {
    var gameBox = await Hive.openBox<Game>('game');
    var games = gameBox.values
        .where((element) => element.status == Status.completed)
        .toList();
    var years = games.map((e) => e.releaseDate!.year).toSet();
    var data = <BarChartGroupData>[];
    for (var year in years) {
      data.add(BarChartGroupData(x: year, showingTooltipIndicators: [
        0
      ], barRods: [
        BarChartRodData(
            colors: [Color(0xffbf616a)],
            y: games
                .where((element) => element.releaseDate!.year == year)
                .length
                .toDouble())
      ]));
    }
    data.sort((a, b) => a.x.compareTo(b.x));
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BarChartGroupData>>(
        future: _getGameCountByGameStatus(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data!;
            return Card(
              margin: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      'Completed Games Count By Release Year',
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    GamesCountByYear(data: data),
                  ],
                ),
              ),
            );
          }
          return Container();
        });
  }
}

class GamesCountByYear extends StatefulWidget {
  final List<BarChartGroupData> data;

  const GamesCountByYear({Key? key, required this.data}) : super(key: key);

  @override
  _GamesCountByYearState createState() => _GamesCountByYearState();
}

class _GamesCountByYearState extends State<GamesCountByYear> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SizedBox(width: 16),
          Container(
            width: widget.data.length * 35,
            child: AspectRatio(
              aspectRatio: 1,
              child: BarChart(
                BarChartData(
                  borderData: FlBorderData(
                    show: false,
                  ),
                  maxY: widget.data
                          .map((e) => e.barRods[0].y.round())
                          .toList()
                          .reduce(max) +
                      1,
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
                  barGroups: widget.data,
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: SideTitles(
                      showTitles: true,
                      getTextStyles: (value) => const TextStyle(
                          color: Color(0xff7589a2),
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
    );
  }
}
