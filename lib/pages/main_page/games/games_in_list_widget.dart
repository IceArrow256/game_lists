import 'package:flutter/material.dart';
import 'package:game_lists/model/game.dart';
import 'package:game_lists/model/status.dart';
import 'package:game_lists/pages/main_page/games_widget_option.dart';
import 'package:game_lists/pages/select_sort_page.dart';
import 'package:hive/hive.dart';

class GamesInListWidget extends StatefulWidget {
  final Status? status;
  final Sort sort;
  final Order order;
  final Set<Sort> availableSort;

  GamesInListWidget({
    Key? key,
    this.status,
    required this.sort,
    required this.order,
    required this.availableSort,
  }) : super(key: key);

  @override
  _GamesInListWidgetState createState() => _GamesInListWidgetState();
}

class SortedGame {
  final Game game;
  DateTime? releaseDate;
  String? developer;
  String? county;
  String? franchise;
  String? genre;
  String? platform;
  DateTime? walkthroughsStartDate;
  DateTime? walkthroughsEndDate;

  SortedGame(
    this.game, {
    this.releaseDate,
    this.developer,
    this.county,
    this.franchise,
    this.genre,
    this.platform,
    this.walkthroughsStartDate,
    this.walkthroughsEndDate,
  });
}

class _GamesInListWidgetState extends State<GamesInListWidget> {
  Sort? _currentSort;
  Order? _currentOrder;
  String _currentSearch = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          onChanged: (value) {
            setState(() {
              _currentSearch = value;
            });
          },
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.filter_list_sharp),
              hintText: 'Filter games by name...'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () async {
                var result = await Navigator.pushNamed(
                    context, SelectSortPage.routeName,
                    arguments: widget.availableSort.toList());
                if (result != null) _currentSort = result as Sort;
              },
              child: Row(
                children: [
                  Icon(Icons.sort),
                  SizedBox(width: 4),
                  Text(sortToString(_currentSort!))
                ],
              ),
            ),
            IconButton(
                icon: Icon(_currentOrder == Order.asc
                    ? Icons.arrow_downward
                    : Icons.arrow_upward),
                onPressed: () {
                  setState(() {
                    if (_currentOrder == Order.asc) {
                      _currentOrder = Order.desk;
                    } else {
                      _currentOrder = Order.asc;
                    }
                  });
                }),
          ],
        ),
        FutureBuilder<List<Game>>(
          future: getGamesInList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              fixCountry(snapshot.data!);

              var games = sortGame(filterGame(snapshot.data!));
              return Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  itemCount: games.length,
                  itemBuilder: (context, i) {
                    var gameInList = games.elementAt(i);
                    return GameInListCard(
                      sortedGame: gameInList,
                    );
                  },
                ),
              );
            }
            return Center();
          },
        ),
      ],
    );
  }

  List<Game> filterGame(List<Game> games) {
    games = games
        .where((element) =>
            element.name.toLowerCase().contains(_currentSearch.toLowerCase()))
        .toList();
    return games;
  }

  Future<List<Game>> getGamesInList() async {
    var gameInListBox = await Hive.openBox<Game>('game');
    if (widget.status != null) {
      return gameInListBox.values
          .where((e) => e.status == widget.status!)
          .toList();
    } else {
      return gameInListBox.values.toList();
    }
  }

  @override
  void initState() {
    _currentSort = widget.sort;
    _currentOrder = widget.order;
    super.initState();
  }

  List<SortedGame> sortGame(List<Game> games) {
    var order = _currentOrder == Order.asc ? 1 : -1;
    var resultGames = <SortedGame>[];
    games.sort((a, b) => a.name.compareTo(b.name));
    switch (_currentSort) {
      case Sort.gameName:
        games.sort((a, b) => order * a.name.compareTo(b.name));
        resultGames = games.map((e) => SortedGame(e)).toList();
        break;
      case Sort.gameDateAdded:
        games.sort((a, b) => order * a.dateAdded.compareTo(b.dateAdded));
        resultGames = games.map((e) => SortedGame(e)).toList();
        break;
      case Sort.gameReleaseDate:
        var gamesByReleaseDate = <SortedGame>[];
        for (var game in games) {
          gamesByReleaseDate.add(SortedGame(game,
              releaseDate:
                  game.releaseDate ?? DateTime.fromMicrosecondsSinceEpoch(0)));
        }
        gamesByReleaseDate
            .sort((a, b) => order * a.releaseDate!.compareTo(b.releaseDate!));
        resultGames = gamesByReleaseDate;
        break;
      case Sort.gameDeveloper:
        var gamesByDeveloper = <SortedGame>[];
        for (var game in games) {
          var isGameAdded = false;
          for (var developer in game.developers) {
            isGameAdded = true;
            gamesByDeveloper.add(
              SortedGame(game, developer: developer.name),
            );
          }
          if (!isGameAdded) {
            gamesByDeveloper.add(
              SortedGame(game, developer: ''),
            );
          }
        }
        gamesByDeveloper
            .sort((a, b) => order * a.developer!.compareTo(b.developer!));
        resultGames = gamesByDeveloper;
        break;
      case Sort.gameCounty:
        var gamesByCounty = <SortedGame>[];
        for (var game in games) {
          var isGameAdded = false;
          for (var developer in game.developers) {
            if (developer.country != null &&
                gamesByCounty
                    .where((e) =>
                        e.county == developer.country &&
                        e.game.giantBombId == game.giantBombId)
                    .isEmpty) {
              isGameAdded = true;
              gamesByCounty.add(
                SortedGame(game, county: developer.country),
              );
            }
          }
          if (!isGameAdded) {
            gamesByCounty.add(
              SortedGame(game, county: ''),
            );
          }
        }
        gamesByCounty.sort((a, b) => order * a.county!.compareTo(b.county!));
        resultGames = gamesByCounty;
        break;
      case Sort.gameFranchise:
        var gamesByFranchise = <SortedGame>[];
        for (var game in games) {
          var isGameAdded = false;
          for (var franchise in game.franchises) {
            isGameAdded = true;
            gamesByFranchise.add(
              SortedGame(game, franchise: franchise.name),
            );
          }
          if (!isGameAdded) {
            gamesByFranchise.add(
              SortedGame(game, franchise: ''),
            );
          }
        }
        gamesByFranchise
            .sort((a, b) => order * a.franchise!.compareTo(b.franchise!));
        resultGames = gamesByFranchise;
        break;
      case Sort.gameGenre:
        var gamesByGenre = <SortedGame>[];
        for (var game in games) {
          var isGameAdded = false;
          for (var genre in game.genres) {
            isGameAdded = true;
            gamesByGenre.add(
              SortedGame(game, genre: genre.name),
            );
          }
          if (!isGameAdded) {
            gamesByGenre.add(
              SortedGame(game, genre: ''),
            );
          }
        }
        gamesByGenre.sort((a, b) => order * a.genre!.compareTo(b.genre!));
        resultGames = gamesByGenre;
        break;
      case Sort.gamePlatform:
        var gamesByPlatform = <SortedGame>[];
        for (var game in games) {
          var isGameAdded = false;
          for (var platform in game.platforms) {
            isGameAdded = true;
            gamesByPlatform.add(
              SortedGame(game, platform: platform.name),
            );
          }
          if (!isGameAdded) {
            gamesByPlatform.add(
              SortedGame(game, platform: ''),
            );
          }
        }
        gamesByPlatform
            .sort((a, b) => order * a.platform!.compareTo(b.platform!));
        resultGames = gamesByPlatform;
        break;
      case Sort.gameRating:
        games.sort((a, b) => order * a.rating.compareTo(b.rating));
        resultGames = games.map((e) => SortedGame(e)).toList();
        break;
      case Sort.gameWalkthroughStartDate:
        var gameWalkthroughsStartDate = <SortedGame>[];
        for (var game in games) {
          if (widget.status != Status.playing) {
            for (var walkthrough in game.walkthroughs) {
              gameWalkthroughsStartDate.add(
                SortedGame(
                  game,
                  walkthroughsStartDate: walkthrough.startDate ??
                      DateTime.fromMicrosecondsSinceEpoch(0),
                ),
              );
            }
          } else {
            bool isGameAdded = false;
            for (var walkthrough in game.walkthroughs) {
              if (walkthrough.endDate == null) {
                isGameAdded = true;
                gameWalkthroughsStartDate.add(
                  SortedGame(
                    game,
                    walkthroughsStartDate: walkthrough.startDate ??
                        DateTime.fromMicrosecondsSinceEpoch(0),
                  ),
                );
              }
            }
            if (!isGameAdded) {
              SortedGame(
                game,
                walkthroughsStartDate: DateTime.fromMicrosecondsSinceEpoch(0),
              );
            }
          }
        }

        gameWalkthroughsStartDate.sort((a, b) =>
            order *
            a.walkthroughsStartDate!.compareTo(b.walkthroughsStartDate!));
        resultGames = gameWalkthroughsStartDate;
        break;
      case Sort.gameWalkthroughEndDate:
        var gameWalkthroughEndDate = <SortedGame>[];
        for (var game in games) {
          for (var walkthrough in game.walkthroughs) {
            gameWalkthroughEndDate.add(
              SortedGame(
                game,
                walkthroughsEndDate: walkthrough.endDate ??
                    DateTime.fromMicrosecondsSinceEpoch(0),
              ),
            );
          }
        }
        gameWalkthroughEndDate.sort((a, b) =>
            order * a.walkthroughsEndDate!.compareTo(b.walkthroughsEndDate!));
        resultGames = gameWalkthroughEndDate;
        break;
      default:
        resultGames = games.map((e) => SortedGame(e)).toList();
    }
    resultGames.forEach((sortedGame) {
      if (sortedGame.walkthroughsStartDate != null &&
          sortedGame.walkthroughsStartDate ==
              DateTime.fromMicrosecondsSinceEpoch(0)) {
        sortedGame.walkthroughsStartDate = null;
      }
      if (sortedGame.walkthroughsEndDate != null &&
          sortedGame.walkthroughsEndDate ==
              DateTime.fromMicrosecondsSinceEpoch(0)) {
        sortedGame.walkthroughsEndDate = null;
      }
      if (sortedGame.releaseDate != null &&
          sortedGame.releaseDate == DateTime.fromMicrosecondsSinceEpoch(0)) {
        sortedGame.releaseDate = null;
      }
      if (sortedGame.county != null && sortedGame.county == '') {
        sortedGame.county = null;
      }
      if (sortedGame.developer != null && sortedGame.developer == '') {
        sortedGame.developer = null;
      }
      if (sortedGame.franchise != null && sortedGame.franchise == '') {
        sortedGame.franchise = null;
      }
      if (sortedGame.genre != null && sortedGame.genre == '') {
        sortedGame.genre = null;
      }
      if (sortedGame.platform != null && sortedGame.platform == '') {
        sortedGame.platform = null;
      }
    });
    return resultGames;
  }
}
