import 'package:flutter/material.dart';
import 'package:game_lists/model/game.dart';
import 'package:game_lists/model/status.dart';
import 'package:game_lists/pages/add_edit_pages/game_in_list_page.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class GameInListCard extends StatelessWidget {
  final Game game;
  const GameInListCard({
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
              Image.network(
                game.imageUrl,
                height: 128,
                width: 96,
                fit: BoxFit.fitHeight,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                child: Container(
                  height: 128,
                  width: MediaQuery.of(context).size.width - 136,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            game.name,
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            game.platforms
                                .map((e) => e.abbreviation)
                                .toList()
                                .join(', '),
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.star_outline,
                                size: 16,
                              ),
                              Text('${game.rating}'),
                            ],
                          ),
                          Text(
                            game.releaseDate != null
                                ? DateFormat('yyyy-MM-dd')
                                    .format(game.releaseDate!)
                                : '',
                            style: TextStyle(fontSize: 14),
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
  final Status status;

  const GamesInListWidget({
    Key? key,
    required this.status,
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

class _GamesInListWidgetState extends State<GamesInListWidget> {
  final DateFormat _formatter = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Game>>(
      future: getGamesInList(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data!;
          return ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 4),
            itemCount: data.length,
            itemBuilder: (context, index) {
              var gameInList = data.elementAt(index);
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
    return gameInListBox.values
        .where((element) => element.status == widget.status)
        .toList();
  }
}

class _GamesWidgetOptionState extends State<GamesWidgetOption> {
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: widget.tabController,
      children: [
        GamesInListWidget(status: Status.playing),
        GamesInListWidget(status: Status.planning),
        GamesInListWidget(status: Status.completed),
        GamesInListWidget(status: Status.pause),
        GamesInListWidget(status: Status.dropped),
      ],
    );
  }
}
