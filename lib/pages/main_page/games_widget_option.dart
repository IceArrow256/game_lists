import 'package:flutter/material.dart';
import 'package:game_lists/model/status.dart';
import 'package:game_lists/pages/game_in_list_page.dart';
import 'package:game_lists/pages/game_page.dart';
import 'package:game_lists/pages/main_page/games/games_in_list_widget.dart';
import 'package:intl/intl.dart';

String sortToString(Sort sort) {
  String result;
  switch (sort) {
    case Sort.gameName:
      result = 'By Name';
      break;
    case Sort.gameDateAdded:
      result = 'By Added Date';
      break;
    case Sort.gameReleaseDate:
      result = 'By Release Date';
      break;
    case Sort.gameDeveloper:
      result = 'By Developer';
      break;
    case Sort.gameCounty:
      result = 'By Country';
      break;
    case Sort.gameFranchise:
      result = 'By Franchise';
      break;
    case Sort.gameGenre:
      result = 'By Genre';
      break;
    case Sort.gamePlatform:
      result = 'By Platform';
      break;
    case Sort.gameRating:
      result = 'By Rating';
      break;
    case Sort.gameWalkthroughEndDate:
      result = 'By Date Finished';
      break;
    case Sort.gameWalkthroughStartDate:
      result = 'By Date Started';
      break;
    default:
      result = 'By';
  }
  return result;
}

class GameInListCard extends StatelessWidget {
  final SortedGame sortedGame;
  GameInListCard({
    Key? key,
    required this.sortedGame,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(4.0),
        onTap: () async {
          await Navigator.pushNamed(context, GameInListPage.routeName,
              arguments: sortedGame.game);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.memory(
                sortedGame.game.image!,
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
                                  sortedGame.game.name,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.blue.shade100),
                                ),
                              ),
                              Visibility(
                                  visible: sortedGame.game.rating != 0,
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
                                          Text('${sortedGame.game.rating}'),
                                        ],
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                          GameInfo(
                            title: 'Date Added',
                            info: DateFormat('yyyy-MM-dd')
                                .format(sortedGame.game.dateAdded),
                            textStyle: TextStyle(fontSize: 12),
                          ),
                          GameInfo(
                            title: 'Release Date',
                            info: sortedGame.releaseDate == null
                                ? null
                                : DateFormat('yyyy-MM-dd')
                                    .format(sortedGame.game.releaseDate!),
                            textStyle: TextStyle(fontSize: 12),
                          ),
                          GameInfo(
                            title: 'Developer',
                            info: sortedGame.developer,
                            textStyle: TextStyle(fontSize: 12),
                          ),
                          GameInfo(
                            title: 'Franchises',
                            info: sortedGame.franchise,
                            textStyle: TextStyle(fontSize: 12),
                          ),
                          GameInfo(
                            title: 'Genre',
                            info: sortedGame.genre,
                            textStyle: TextStyle(fontSize: 12),
                          ),
                          GameInfo(
                            title: 'County',
                            info: sortedGame.county,
                            textStyle: TextStyle(fontSize: 12),
                          ),
                          GameInfo(
                            title: 'Platform',
                            info: sortedGame.platform,
                            textStyle: TextStyle(fontSize: 12),
                          ),
                          GameInfo(
                            title: 'Date started',
                            info: sortedGame.walkthroughsStartDate == null
                                ? null
                                : DateFormat('yyyy-MM-dd')
                                    .format(sortedGame.walkthroughsStartDate!),
                            textStyle: TextStyle(fontSize: 12),
                          ),
                          GameInfo(
                            title: 'Date finished ',
                            info: sortedGame.walkthroughsEndDate == null
                                ? null
                                : DateFormat('yyyy-MM-dd')
                                    .format(sortedGame.walkthroughsEndDate!),
                            textStyle: TextStyle(fontSize: 12),
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

class GamesWidgetOption extends StatefulWidget {
  final TabController? tabController;

  GamesWidgetOption({Key? key, this.tabController}) : super(key: key);

  @override
  _GamesWidgetOptionState createState() => _GamesWidgetOptionState();
}

enum Order {
  asc,
  desk,
}

enum Sort {
  gameName,
  gameDateAdded,
  gameReleaseDate,
  gameDeveloper,
  gameCounty,
  gameFranchise,
  gameGenre,
  gamePlatform,
  gameRating,
  gameWalkthroughEndDate,
  gameWalkthroughStartDate,
}

class _GamesWidgetOptionState extends State<GamesWidgetOption> {
  @override
  Widget build(BuildContext context) {
    var _availableSortWithoutWalkthrough = {
      Sort.gameName,
      Sort.gameDateAdded,
      Sort.gameReleaseDate,
      Sort.gameDeveloper,
      Sort.gameCounty,
      Sort.gameFranchise,
      Sort.gameGenre,
      Sort.gamePlatform,
      Sort.gameRating,
    };
    var _availableSortWithStartDate =
        Set<Sort>.from(_availableSortWithoutWalkthrough)
          ..addAll([Sort.gameWalkthroughStartDate]);
    var _availableSortWithEndDate =
        Set<Sort>.from(_availableSortWithoutWalkthrough)
          ..addAll([Sort.gameWalkthroughEndDate]);
    var _availableSortAll = Set<Sort>.from(_availableSortWithStartDate)
      ..addAll([Sort.gameWalkthroughEndDate]);

    return TabBarView(
      controller: widget.tabController,
      children: [
        GamesInListWidget(
          status: Status.playing,
          sort: Sort.gameWalkthroughStartDate,
          order: Order.desk,
          availableSort: _availableSortWithStartDate,
        ),
        GamesInListWidget(
          status: Status.planning,
          sort: Sort.gameDateAdded,
          order: Order.desk,
          availableSort: _availableSortWithoutWalkthrough,
        ),
        GamesInListWidget(
          status: Status.completed,
          sort: Sort.gameWalkthroughEndDate,
          order: Order.desk,
          availableSort: _availableSortAll,
        ),
        GamesInListWidget(
          status: Status.pause,
          sort: Sort.gameWalkthroughStartDate,
          order: Order.desk,
          availableSort: _availableSortWithStartDate,
        ),
        GamesInListWidget(
          status: Status.dropped,
          sort: Sort.gameWalkthroughStartDate,
          order: Order.desk,
          availableSort: _availableSortWithStartDate,
        ),
        GamesInListWidget(
          sort: Sort.gameDateAdded,
          order: Order.desk,
          availableSort: _availableSortAll,
        ),
      ],
    );
  }
}
