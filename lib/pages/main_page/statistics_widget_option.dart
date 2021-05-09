import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:game_lists/model/game.dart';
import 'package:game_lists/model/status.dart';
import 'package:game_lists/pages/main_page/charts/games_count_by_game_status_widget.dart';
import 'package:game_lists/pages/main_page/charts/games_count_by_year.dart';
import 'package:hive/hive.dart';

class StatisticsWidgetOption extends StatefulWidget {
  StatisticsWidgetOption({Key? key, this.tabController}) : super(key: key);

  @override
  _StatisticsWidgetOptionState createState() => _StatisticsWidgetOptionState();

  final TabController? tabController;
}

class _StatisticsWidgetOptionState extends State<StatisticsWidgetOption> {
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: widget.tabController,
      children: [
        ListView(
          children: [
            GamesCountByGameStatusWidget(),
            CompletedGamesCountByFinishYear(),
            CompletedGamesCountByReleaseYear(),
          ],
        ),
        Icon(Icons.directions_transit),
      ],
    );
  }
}
