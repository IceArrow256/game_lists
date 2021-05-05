import 'package:flutter/material.dart';
import 'package:game_lists/game_lists.dart';
import 'package:game_lists/model/game_in_list.dart';
import 'package:game_lists/model/status.dart';
import 'package:game_lists/pages/add_edit_pages/game_in_list_page.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class GamesWidgetOption extends StatefulWidget {
  GamesWidgetOption({Key? key, this.tabController}) : super(key: key);

  @override
  _GamesWidgetOptionState createState() => _GamesWidgetOptionState();

  final TabController? tabController;
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

class GamesInListWidget extends StatefulWidget {
  const GamesInListWidget({
    Key? key,
    required this.status,
  }) : super(key: key);

  final Status status;

  @override
  _GamesInListWidgetState createState() => _GamesInListWidgetState();
}

class _GamesInListWidgetState extends State<GamesInListWidget> {
  final DateFormat _formatter = DateFormat('yyyy-MM-dd');

  Future<List<GameInList>> getGamesInList() async {
    var gameInListBox = await Hive.openBox<GameInList>('gameInList');
    return gameInListBox.values
        .where((element) => element.status == widget.status)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<GameInList>>(
      future: getGamesInList(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data!;
          return ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 4),
            itemCount: data.length,
            itemBuilder: (context, index) {
              var gameInList = data.elementAt(index);
              List<String> platforms = [];
              for (var platform in gameInList.game.platforms) {
                platforms.add(platform.abbreviation);
              }
              return GameInListCard(
                imageUrl: gameInList.game.imageUrl,
                name: gameInList.game.name,
                platforms: platforms,
                releaseDate: gameInList.game.releaseDate != null
                    ? _formatter.format(gameInList.game.releaseDate!)
                    : '',
                onTap: () {
                  // Navigator.pushNamed(context, GameInListPage.routeName,
                  //     arguments: game['id']);
                },
              );
              return Container();
            },
          );
        }
        return Center();
      },
    );
  }
}

class GameInListCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final List<String> platforms;
  final String releaseDate;
  final VoidCallback onTap;
  const GameInListCard(
      {Key? key,
      required this.imageUrl,
      required this.name,
      required this.platforms,
      required this.releaseDate,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(4.0),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                imageUrl,
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
                            name,
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            platforms.join(', '),
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(releaseDate, style: TextStyle(fontSize: 14)),
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
