import 'package:flutter/material.dart';
import 'package:game_list/db/dao/game_dao.dart';
import 'package:game_list/db/dao/game_in_list_dao.dart';
import 'package:game_list/db/database.dart';
import 'package:game_list/pages/game_in_list/game_in_list_view.dart';

class GamesTab extends StatefulWidget {
  final String search;
  final AppDatabase database;

  const GamesTab({Key key, this.database, this.search}) : super(key: key);

  @override
  _GamesTabState createState() => _GamesTabState();
}

class _GamesTabState extends State<GamesTab> {
  GameInListDao _gameInListDao;
  GameDao _gameDao;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, Object>>>(
      future: _getGamesInList(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length + 1,
            itemBuilder: (context, i) {
              if (i == 0) {
                return SizedBox(height: 4);
              } else {
                var gamesInList = snapshot.data;
                var date = gamesInList[i - 1]['dateAdded'] as DateTime;
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(6.0),
                    onTap: () async {
                      await Navigator.pushNamed(
                          context, GameInListView.routeName,
                          arguments: gamesInList[i - 1]);
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
                              gamesInList[i - 1]['coverUrl'],
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
                                    gamesInList[i - 1]['name'],
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    'Date added: ${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}',
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
        } else {
          return Container();
        }
      },
    );
  }

  @override
  void initState() {
    _gameInListDao = widget.database.gameInListDao;
    _gameDao = widget.database.gameDao;
    super.initState();
  }

  Future<List<Map<String, Object>>> _getGamesInList() async {
    List<Map<String, Object>> objects = [];
    for (var gameInList in await _gameInListDao.findAll()) {
      var game = await _gameDao.findById(gameInList.gameId);
      objects.add({
        'id': gameInList.id,
        'gameId': game.id,
        'name': game.name,
        'coverUrl': game.coverUrl,
        'dateAdded': gameInList.dateAdded,
        'status': gameInList.status,
      });
    }
    return objects;
  }
}
