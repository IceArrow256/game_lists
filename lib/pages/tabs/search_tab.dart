import 'package:flutter/material.dart';
import 'package:game_list/db/dao/game_dao.dart';
import 'package:game_list/db/database.dart';
import 'package:game_list/db/model/game.dart';
import 'package:game_list/pages/game/game_view.dart';

class SearchTab extends StatefulWidget {
  final String search;
  final AppDatabase database;

  const SearchTab({Key key, this.database, this.search}) : super(key: key);

  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  GameDao gameDao;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Game>>(
      stream: gameDao.findAllAsStreamByName('%${widget.search}%'),
      builder: (_, snapshot) {
        if (!snapshot.hasData) return Container();

        final games = snapshot.data;

        return ListView.builder(
          itemCount: games.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return SizedBox(height: 4);
            } else {
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: InkWell(
                  borderRadius: BorderRadius.circular(6.0),
                  onTap: () async {
                    await Navigator.pushNamed(context, GameView.routeName,
                        arguments: games[index - 1]);
                    setState(() {});
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(2.0),
                          child: Image.network(
                            games[index - 1].coverUrl,
                            width: 100,
                            height: 133,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  games[index - 1].name,
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }

  @override
  void initState() {
    gameDao = widget.database.gameDao;
    super.initState();
  }
}
