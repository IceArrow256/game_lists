import 'dart:math';

import 'package:flutter/material.dart';
import 'package:game_lists/model/developer.dart';
import 'package:game_lists/model/game.dart';
import 'package:game_lists/model/status.dart';
import 'package:game_lists/pages/main_page/stats/bar_chart_card_widget.dart';
import 'package:game_lists/pages/main_page/stats/pie_chart_card_widget.dart';
import 'package:game_lists/pages/main_page/stats/stats_card_widget.dart';
import 'package:hive/hive.dart';

List<Color> top6colors = [
  Color(0xffbf616a),
  Color(0xffd08770),
  Color(0xffebcb8b),
  Color(0xffa3be8c),
  Color(0xffb48ead),
  Color(0xff5e81ac),
];

class MainStats {
  final int totalGame;
  final double meanRating;
  final double standardDeviation;
  MainStats(this.totalGame, this.meanRating, this.standardDeviation);
}

class StatisticsWidgetOption extends StatefulWidget {
  final TabController? tabController;

  StatisticsWidgetOption({Key? key, this.tabController}) : super(key: key);

  @override
  _StatisticsWidgetOptionState createState() => _StatisticsWidgetOptionState();
}

class _StatisticsWidgetOptionState extends State<StatisticsWidgetOption> {
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: widget.tabController,
      children: [
        FutureBuilder<Map<String, dynamic>>(
            future: getDataForMainTab(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data!;
                var mainStats = data['mainStats'] as MainStats;
                var numberOfGamesByGameStatus =
                    data['numberOfGamesByGameStatus'] as List<PieChartCardData>;
                var numberOfGamesCompletedByYearOfRelease =
                    data['numberOfGamesCompletedByYearOfRelease']
                        as List<BarChartCardData>;
                var numberOfGamesCompletedByYearOfComplete =
                    data['numberOfGamesCompletedByYearOfComplete']
                        as List<BarChartCardData>;
                var numberOfGamesCompletedByRating =
                    data['numberOfGamesCompletedByRating']
                        as List<BarChartCardData>;
                return ListView(
                  children: [
                    StatsCardWidget(
                      title: 'Main Stats',
                      children: <StatElementWidget>[
                        StatElementWidget(
                          color: Color(0xffbf616a),
                          title: 'Total Game',
                          value: mainStats.totalGame.toString(),
                        ),
                        StatElementWidget(
                          color: Color(0xffebcb8b),
                          title: 'Mean Rating',
                          value: mainStats.meanRating.toStringAsPrecision(3),
                        ),
                        StatElementWidget(
                          color: Color(0xffb48ead),
                          title: 'Standard Deviation',
                          value: mainStats.standardDeviation
                              .toStringAsPrecision(3),
                        )
                      ],
                    ),
                    PieChartCardWidget(
                      title: 'Number of Games by Game Status',
                      data: numberOfGamesByGameStatus,
                    ),
                    BarChartCardWidget(
                      title: 'Number of Games Completed by Year of Release',
                      data: numberOfGamesCompletedByYearOfRelease,
                      color: Color(0xffbf616a),
                    ),
                    BarChartCardWidget(
                      title: 'Number of Games Completed by Year of Complete',
                      data: numberOfGamesCompletedByYearOfComplete,
                      color: Color(0xffd08770),
                    ),
                    BarChartCardWidget(
                      title: 'Number of Games Completed by Rating',
                      data: numberOfGamesCompletedByRating,
                      color: Color(0xffebcb8b),
                    ),
                  ],
                );
              }
              return Container();
            }),
        FutureBuilder<Map<String, dynamic>>(
            future: getDataForTopTab(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data!;
                var top6Countries =
                    data['top6Countries'] as List<PieChartCardData>;
                var top6Developers =
                    data['top6Developers'] as List<PieChartCardData>;
                return ListView(
                  children: [
                    PieChartCardWidget(
                      title: 'Top 6 Countries by Number of Games',
                      data: top6Countries,
                    ),
                    PieChartCardWidget(
                      title: 'Top 6 Developers by Number of Games',
                      data: top6Developers,
                    ),
                  ],
                );
              }
              return Container();
            }),
      ],
    );
  }

  void fixCountry(List<Game> games) async {
    games.forEach((game) {
      game.developers.forEach((developer) {
        if (developer.country == 'USA') developer.country = 'United States';
        if (developer.country == 'United States of America')
          developer.country = 'United States';
      });
    });
  }

  Future<Map<String, dynamic>> getDataForMainTab() async {
    var data = <String, dynamic>{};
    data['mainStats'] = await getMainStats();
    data['numberOfGamesByGameStatus'] = await getNumberOfGamesByGameStatus();
    data['numberOfGamesCompletedByYearOfRelease'] =
        await getNumberOfGamesCompletedByYearOfRelease();
    data['numberOfGamesCompletedByYearOfComplete'] =
        await getNumberOfGamesCompletedByYearOfComplete();
    data['numberOfGamesCompletedByRating'] =
        await getNumberOfGamesCompletedByRating();
    return data;
  }

  Future<Map<String, dynamic>> getDataForTopTab() async {
    var data = <String, dynamic>{};
    data['top6Countries'] = await getTop6Countries();
    data['top6Developers'] = await getTop6Developers();
    return data;
  }

  Future<MainStats> getMainStats() async {
    var gameBox = await Hive.openBox<Game>('game');
    var games = gameBox.values
        .where((element) =>
            element.status == Status.completed ||
            element.status == Status.playing)
        .toList();
    var gamesWithScore = games.where((element) => element.rating != 0);
    var meanRating =
        gamesWithScore.map((e) => e.rating).reduce((a, b) => a + b) /
            gamesWithScore.length;
    var deviations =
        gamesWithScore.map((e) => pow(e.rating - meanRating, 2)).toList();
    var standardDeviation =
        deviations.reduce((a, b) => a + b) / gamesWithScore.length;
    return MainStats(
      games.length,
      meanRating,
      standardDeviation,
    );
  }

  Future<List<PieChartCardData>> getNumberOfGamesByGameStatus() async {
    var gameBox = await Hive.openBox<Game>('game');
    var data = <PieChartCardData>[];
    data.add(
      PieChartCardData(
        title: 'All',
        value: gameBox.values.length,
        color: Color(0xff8fbcbb),
        isHide: true,
      ),
    );
    data.add(
      PieChartCardData(
        title: 'Playing',
        value: gameBox.values
            .where((element) => element.status == Status.playing)
            .length,
        color: Color(0xffbf616a),
      ),
    );
    data.add(
      PieChartCardData(
        title: 'Planning',
        value: gameBox.values
            .where((element) => element.status == Status.planning)
            .length,
        color: Color(0xffd08770),
      ),
    );
    data.add(
      PieChartCardData(
        title: 'Completed',
        value: gameBox.values
            .where((element) => element.status == Status.completed)
            .length,
        color: Color(0xffebcb8b),
      ),
    );
    data.add(
      PieChartCardData(
        title: 'Pause',
        value: gameBox.values
            .where((element) => element.status == Status.pause)
            .length,
        color: Color(0xffa3be8c),
      ),
    );
    data.add(
      PieChartCardData(
        title: 'Dropped',
        value: gameBox.values
            .where((element) => element.status == Status.dropped)
            .length,
        color: Color(0xffb48ead),
      ),
    );
    return data;
  }

  Future<List<BarChartCardData>> getNumberOfGamesCompletedByRating() async {
    var gameBox = await Hive.openBox<Game>('game');
    var games = gameBox.values
        .where((element) => element.status == Status.completed)
        .toList();
    var ratings = games
        .where((element) => element.rating != 0)
        .map((e) => e.rating)
        .toSet();
    var data = <BarChartCardData>[];
    for (var rating in ratings) {
      data.add(BarChartCardData(
          x: rating,
          y: games.where((element) => element.rating == rating).length));
    }
    data.sort((a, b) => a.x.compareTo(b.x));
    return data;
  }

  Future<List<BarChartCardData>>
      getNumberOfGamesCompletedByYearOfComplete() async {
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
    var data = <BarChartCardData>[];
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
      data.add(BarChartCardData(x: year, y: count));
    }
    data.sort((a, b) => a.x.compareTo(b.x));
    return data;
  }

  Future<List<BarChartCardData>>
      getNumberOfGamesCompletedByYearOfRelease() async {
    var gameBox = await Hive.openBox<Game>('game');
    var games = gameBox.values
        .where((element) => element.status == Status.completed)
        .toList();
    var years = <int>{};
    for (var game in games) {
      if (game.releaseDate != null) {
        years.add(game.releaseDate!.year);
      }
    }
    var data = <BarChartCardData>[];
    for (var year in years) {
      int count = 0;
      for (var game in games) {
        if (game.releaseDate != null && game.releaseDate!.year == year) {
          count++;
        }
      }
      data.add(BarChartCardData(x: year, y: count));
    }
    data.sort((a, b) => a.x.compareTo(b.x));
    return data;
  }

  Future<List<PieChartCardData>> getTop6Countries() async {
    var gameBox = await Hive.openBox<Game>('game');
    var games = gameBox.values
        .where((element) =>
            element.status == Status.completed ||
            element.status == Status.playing)
        .toList();
    fixCountry(games);
    var data = <PieChartCardData>[];
    var countries = <String>{};
    for (var game in games) {
      for (var developer in game.developers) {
        if (developer.country != null) {
          countries.add(developer.country!);
        }
      }
    }
    for (var country in countries) {
      int count = 0;
      for (var game in games) {
        for (var developer in game.developers) {
          if (developer.country != null && developer.country! == country) {
            count++;
          }
        }
      }
      data.add(
          PieChartCardData(title: country, value: count, color: Colors.white));
    }
    data.sort((a, b) => -1 * a.value.compareTo(b.value));
    var top6Data = <PieChartCardData>[];
    for (var i = 0; i < 6; i++) {
      if (data.length > i) {
        top6Data.add(PieChartCardData(
            title: data[i].title, value: data[i].value, color: top6colors[i]));
      }
    }
    return top6Data;
  }

  Future<List<PieChartCardData>> getTop6Developers() async {
    var gameBox = await Hive.openBox<Game>('game');
    var developerBox = await Hive.openBox<Developer>('developer');
    var games = gameBox.values
        .where((element) =>
            element.status == Status.completed ||
            element.status == Status.playing)
        .toList();
    var data = <PieChartCardData>[];
    var developer_ids = <int>{};
    games.forEach((element) {
      developer_ids.addAll(element.developers.map((e) => e.giantBombId!));
    });
    for (var developer_id in developer_ids) {
      int count = 0;
      for (var game in games) {
        for (var developer in game.developers) {
          if (developer_id == developer.giantBombId) {
            count++;
          }
        }
      }
      data.add(PieChartCardData(
          title: developerBox.values
              .where((element) => element.giantBombId == developer_id)
              .first
              .name,
          value: count,
          color: Colors.white));
    }
    data.sort((a, b) => -1 * a.value.compareTo(b.value));
    var top6Data = <PieChartCardData>[];
    for (var i = 0; i < 6; i++) {
      if (data.length > i) {
        top6Data.add(PieChartCardData(
            title: data[i].title, value: data[i].value, color: top6colors[i]));
      }
    }
    return top6Data;
  }
}
