import 'dart:math';

import 'package:flutter/material.dart';
import 'package:game_lists/model/developer.dart';
import 'package:game_lists/model/franchise.dart';
import 'package:game_lists/model/game.dart';
import 'package:game_lists/model/genre.dart';
import 'package:game_lists/model/status.dart';
import 'package:game_lists/pages/main_page/stats/bar_chart_card_widget.dart';
import 'package:game_lists/pages/main_page/stats/pie_chart_card_widget.dart';
import 'package:game_lists/pages/main_page/stats/stats_card_widget.dart';
import 'package:hive/hive.dart';

List<Color> top6colors = [
  Color(0xffbf616a),
  Color(0xffd08770),
  Color(0xff88c0d0),
  Color(0xffebcb8b),
  Color(0xffa3be8c),
  Color(0xff5e81ac),
  Color(0xffb48ead),
  Color(0xffC65ECC),
  Color(0xff4c566a),
];

List<BarChartCardData> generateCompletedGamesByCompleteYear(List<Game> games) {
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
        if (walkthrough.endDate != null && walkthrough.endDate!.year == year) {
          count++;
        }
      }
    }
    data.add(BarChartCardData(x: year, y: count));
  }
  data.sort((a, b) => a.x.compareTo(b.x));
  return data;
}

List<BarChartCardData> generateCompletedGamesByRating(List<Game> games) {
  var ratings =
      games.where((e) => e.rating != 0).map((game) => game.rating).toSet();
  var data = <BarChartCardData>[];
  for (var rating in ratings) {
    data.add(BarChartCardData(
        x: rating, y: games.where((e) => e.rating == rating).length));
  }
  data.sort((a, b) => a.x.compareTo(b.x));
  return data;
}

List<BarChartCardData> generateCompletedGamesByReleaseYear(List<Game> games) {
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

List<PieChartCardData> generateGamesByGameStatus(Box<Game> gameBox) {
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
      value: gameBox.values.where((e) => e.status == Status.playing).length,
      color: Color(0xffbf616a),
    ),
  );
  data.add(
    PieChartCardData(
      title: 'Planning',
      value: gameBox.values.where((e) => e.status == Status.planning).length,
      color: Color(0xffd08770),
    ),
  );
  data.add(
    PieChartCardData(
      title: 'Completed',
      value: gameBox.values.where((e) => e.status == Status.completed).length,
      color: Color(0xffebcb8b),
    ),
  );
  data.add(
    PieChartCardData(
      title: 'Pause',
      value: gameBox.values.where((e) => e.status == Status.pause).length,
      color: Color(0xffa3be8c),
    ),
  );
  data.add(
    PieChartCardData(
      title: 'Dropped',
      value: gameBox.values.where((e) => e.status == Status.dropped).length,
      color: Color(0xffb48ead),
    ),
  );
  return data;
}

List<StatElementWidget> generateMainStats(Box<Game> gameBox) {
  var games = gameBox.values
      .where((e) => e.status == Status.completed || e.status == Status.playing)
      .toList();
  var gamesWithScore = gameBox.values.where((e) => e.rating != 0);
  var meanRating = gamesWithScore.map((e) => e.rating).reduce((a, b) => a + b) /
      gamesWithScore.length;
  var deviations =
      gamesWithScore.map((e) => pow(e.rating - meanRating, 2)).toList();
  var standardDeviation =
      deviations.reduce((a, b) => a + b) / gamesWithScore.length;
  var mainStats = <StatElementWidget>[];
  mainStats.add(
    StatElementWidget(
      color: Color(0xffbf616a),
      title: 'Total Game',
      value: games.length.toString(),
    ),
  );
  mainStats.add(
    StatElementWidget(
      color: Color(0xffebcb8b),
      title: 'Mean Rating',
      value: meanRating.toStringAsPrecision(3),
    ),
  );
  mainStats.add(
    StatElementWidget(
      color: Color(0xffb48ead),
      title: 'Standard Deviation',
      value: standardDeviation.toStringAsPrecision(3),
    ),
  );
  return mainStats;
}

Future<Stats> generateStats() async {
  var gameBox = await Hive.openBox<Game>('game');
  var developerBox = await Hive.openBox<Developer>('developer');
  var franchiseBox = await Hive.openBox<Franchise>('franchise');
  var genreBox = await Hive.openBox<Genre>('genre');
  var completedGames =
      gameBox.values.where((e) => e.status == Status.completed).toList();
  var games = gameBox.values
      .where((e) => e.status == Status.completed || e.status == Status.playing)
      .toList();
  var developers = developerBox.values.toList()
    ..sort((a, b) => a.name.compareTo(b.name));
  var franchises = franchiseBox.values.toList()
    ..sort((a, b) => a.name.compareTo(b.name));
  var genres = genreBox.values.toList()
    ..sort((a, b) => a.name.compareTo(b.name));
  return Stats(
      mainStats: generateMainStats(gameBox),
      gameByGameStatus: generateGamesByGameStatus(gameBox),
      completedGamesByReleaseYear:
          generateCompletedGamesByReleaseYear(completedGames),
      completedGamesByCompleteYear:
          generateCompletedGamesByCompleteYear(completedGames),
      completedGamesByRating: generateCompletedGamesByRating(completedGames),
      topDevelopers: generateTopDeveloper(games, developers),
      topCountries: generateTopCountries(games),
      topFranchises: generateTopFranchises(games, franchises),
      topGenres: generateTopGenres(games, genres));
}

List<PieChartCardData> generateTopCountries(List<Game> games) {
  fixCountry(games);
  var data = <PieChartCardData>[];
  var countries = <String?>[];
  games.forEach((game) {
    countries.addAll(game.developers.map((e) => e.country));
  });

  for (var country in countries.toSet()) {
    if (country != null)
      data.add(PieChartCardData(
          title: country,
          value: countries.where((e) => e == country).length,
          color: Colors.white));
  }
  data.sort((a, b) => -1 * a.value.compareTo(b.value));
  data = data.take(9).toList();
  for (var i = 0; i < min(9, data.length); i++) data[i].color = top6colors[i];
  return data;
}

List<PieChartCardData> generateTopDeveloper(
    List<Game> games, List<Developer> developers) {
  var data = <PieChartCardData>[];
  var gameDevelopers = <Developer>[];
  games.forEach((game) {
    gameDevelopers.addAll(game.developers);
  });
  for (var developer in developers) {
    data.add(PieChartCardData(
        title: developer.name,
        value: gameDevelopers
            .where((e) => e.giantBombId == developer.giantBombId)
            .length,
        color: Colors.white));
  }
  data.sort((a, b) => -1 * a.value.compareTo(b.value));
  data = data.take(9).toList();
  for (var i = 0; i < min(9, data.length); i++) data[i].color = top6colors[i];
  return data;
}

List<PieChartCardData> generateTopFranchises(
    List<Game> games, List<Franchise> franchises) {
  var data = <PieChartCardData>[];
  var gameFranchises = <Franchise>[];
  games.forEach((game) {
    gameFranchises.addAll(game.franchises);
  });
  for (var franchise in franchises) {
    data.add(PieChartCardData(
        title: franchise.name,
        value: gameFranchises
            .where((e) => e.giantBombId == franchise.giantBombId)
            .length,
        color: Colors.white));
  }
  data.sort((a, b) => -1 * a.value.compareTo(b.value));
  data = data.take(9).toList();
  for (var i = 0; i < min(9, data.length); i++) data[i].color = top6colors[i];
  return data;
}

List<PieChartCardData> generateTopGenres(List<Game> games, List<Genre> genres) {
  var data = <PieChartCardData>[];
  var gameGenres = <Genre>[];
  games.forEach((game) {
    gameGenres.addAll(game.genres);
  });
  for (var genre in genres) {
    data.add(PieChartCardData(
        title: genre.name,
        value:
            gameGenres.where((e) => e.giantBombId == genre.giantBombId).length,
        color: Colors.white));
  }
  data.sort((a, b) => -1 * a.value.compareTo(b.value));
  data = data.take(9).toList();
  for (var i = 0; i < min(9, data.length); i++) data[i].color = top6colors[i];
  return data;
}

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

class Stats {
  final List<StatElementWidget> mainStats;
  final List<PieChartCardData> gameByGameStatus;
  final List<BarChartCardData> completedGamesByReleaseYear;
  final List<BarChartCardData> completedGamesByCompleteYear;
  final List<BarChartCardData> completedGamesByRating;
  final List<PieChartCardData> topDevelopers;
  final List<PieChartCardData> topCountries;
  final List<PieChartCardData> topFranchises;
  final List<PieChartCardData> topGenres;

  Stats({
    required this.mainStats,
    required this.gameByGameStatus,
    required this.completedGamesByReleaseYear,
    required this.completedGamesByCompleteYear,
    required this.completedGamesByRating,
    required this.topDevelopers,
    required this.topCountries,
    required this.topFranchises,
    required this.topGenres,
  });
}

class _StatisticsWidgetOptionState extends State<StatisticsWidgetOption> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Stats>(
      future: generateStats(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var stats = snapshot.data! as Stats;
          return TabBarView(
            controller: widget.tabController,
            children: [
              ListView(
                children: [
                  StatsCardWidget(
                    title: 'Main Stats',
                    children: stats.mainStats,
                  ),
                  PieChartCardWidget(
                    title: 'Number of Games by Game Status',
                    data: stats.gameByGameStatus,
                  ),
                  BarChartCardWidget(
                    title: 'Number of Games Completed by Year of Release',
                    data: stats.completedGamesByReleaseYear,
                    color: Color(0xffbf616a),
                  ),
                  BarChartCardWidget(
                    title: 'Number of Games Completed by Year of Complete',
                    data: stats.completedGamesByCompleteYear,
                    color: Color(0xffd08770),
                  ),
                  BarChartCardWidget(
                    title: 'Number of Games Completed by Rating',
                    data: stats.completedGamesByRating,
                    color: Color(0xffebcb8b),
                  ),
                ],
              ),
              ListView(
                children: [
                  PieChartCardWidget(
                    title: 'Top 6 Developers by Number of Games',
                    data: stats.topDevelopers,
                  ),
                  PieChartCardWidget(
                    title: 'Top 6 Countries by Number of Games',
                    data: stats.topCountries,
                  ),
                  PieChartCardWidget(
                    title: 'Top 6 Franchises by Number of Games',
                    data: stats.topFranchises,
                  ),
                  PieChartCardWidget(
                    title: 'Top 6 Genres by Number of Games',
                    data: stats.topGenres,
                  ),
                ],
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}
