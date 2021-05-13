import 'package:flutter/material.dart';
import 'package:game_lists/model/game.dart';
import 'package:game_lists/model/status.dart';
import 'package:game_lists/pages/add_edit_pages/game_in_list_page.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class GameInListCard extends StatelessWidget {
  final Game game;
  GameInListCard({
    Key? key,
    required this.game,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(4.0),
        onTap: () async {
          await Navigator.pushNamed(context, GameInListPage.routeName,
              arguments: game);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.memory(
                game.image!,
                width: 96,
                fit: BoxFit.fitHeight,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                child: Container(
                  width: MediaQuery.of(context).size.width - 136,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  game.name,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.blue.shade100),
                                ),
                              ),
                              Visibility(
                                  visible: game.rating != 0,
                                  child: Column(
                                    children: [
                                      SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star_outline,
                                            size: 16,
                                            color: Colors.yellow,
                                          ),
                                          Text('${game.rating}'),
                                        ],
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                          Visibility(
                            visible: game.platforms.isNotEmpty,
                            child: Column(
                              children: [
                                SizedBox(height: 4),
                                Text(
                                    game.platforms
                                        .map((e) => e.abbreviation)
                                        .toList()
                                        .join(', '),
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(fontSize: 12)),
                              ],
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            game.releaseDate != null
                                ? 'Release Date: ${DateFormat('yyyy-MM-dd').format(game.releaseDate!)}'
                                : '',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GamesInListWidget extends StatefulWidget {
  final Status? status;
  final Sort sort;
  final Order order;

  GamesInListWidget({
    Key? key,
    this.status,
    required this.sort,
    required this.order,
  }) : super(key: key);

  @override
  _GamesInListWidgetState createState() => _GamesInListWidgetState();
}

class GamesWidgetOption extends StatefulWidget {
  final TabController? tabController;

  GamesWidgetOption({Key? key, this.tabController}) : super(key: key);

  @override
  _GamesWidgetOptionState createState() => _GamesWidgetOptionState();
}

class GameWalkthrough {
  final Game game;

  final DateTime walkthrough;
  const GameWalkthrough(this.game, this.walkthrough);
}

enum Order {
  asc,
  desk,
}

enum Sort {
  gameName,
  gameDateAdded,
  gameWalkthroughsEndDate,
  gameWalkthroughsStartDate,
}

class _GamesInListWidgetState extends State<GamesInListWidget> {
  final DateFormat _formatter = DateFormat('yyyy-MM-dd');
  Sort? _currentSort;
  Order? _currentOrder;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Game>>(
      future: getGamesInList(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var games = sortGame(snapshot.data!);
          return ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 4),
            itemCount: games.length,
            itemBuilder: (context, i) {
              var gameInList = games.elementAt(i);
              return GameInListCard(
                game: gameInList,
              );
            },
          );
        }
        return Center();
      },
    );
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

  List<Game> sortGame(List<Game> games) {
    var order = _currentOrder == Order.asc ? 1 : -1;
    var resultGames = <Game>[];
    switch (_currentSort) {
      case Sort.gameName:
        games.sort((a, b) => order * a.name.compareTo(b.name));
        resultGames = games;
        break;
      case Sort.gameName:
        games.sort((a, b) => order * a.dateAdded.compareTo(b.dateAdded));
        resultGames = games;
        break;
      case Sort.gameWalkthroughsStartDate:
        var gameWalkthrough = <GameWalkthrough>[];
        for (var game in games) {
          for (var walkthrough in game.walkthroughs) {
            gameWalkthrough.add(
              GameWalkthrough(
                game,
                walkthrough.startDate ?? DateTime.fromMicrosecondsSinceEpoch(0),
              ),
            );
          }
        }
        gameWalkthrough
            .sort((a, b) => order * a.walkthrough.compareTo(b.walkthrough));
        resultGames = gameWalkthrough.map((e) => e.game).toList();
        break;
      case Sort.gameWalkthroughsEndDate:
        var gameWalkthrough = <GameWalkthrough>[];
        for (var game in games) {
          for (var walkthrough in game.walkthroughs) {
            gameWalkthrough.add(
              GameWalkthrough(
                game,
                walkthrough.endDate ?? DateTime.fromMicrosecondsSinceEpoch(0),
              ),
            );
          }
        }
        gameWalkthrough
            .sort((a, b) => order * a.walkthrough.compareTo(b.walkthrough));
        resultGames = gameWalkthrough.map((e) => e.game).toList();
        break;
      case Sort.gameDateAdded:
        games.sort((a, b) => order * a.dateAdded.compareTo(b.dateAdded));
        resultGames = games;
        break;
      default:
        resultGames = games;
    }
    return resultGames;
  }
}

class _GamesWidgetOptionState extends State<GamesWidgetOption> {
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: widget.tabController,
      children: [
        GamesInListWidget(
          status: Status.playing,
          sort: Sort.gameWalkthroughsStartDate,
          order: Order.desk,
        ),
        GamesInListWidget(
          status: Status.planning,
          sort: Sort.gameDateAdded,
          order: Order.desk,
        ),
        GamesInListWidget(
            status: Status.completed,
            sort: Sort.gameWalkthroughsEndDate,
            order: Order.desk),
        GamesInListWidget(
          status: Status.pause,
          sort: Sort.gameWalkthroughsStartDate,
          order: Order.desk,
        ),
        GamesInListWidget(
          status: Status.dropped,
          sort: Sort.gameWalkthroughsStartDate,
          order: Order.desk,
        ),
        GamesInListWidget(
          sort: Sort.gameDateAdded,
          order: Order.desk,
        ),
      ],
    );
  }
}
