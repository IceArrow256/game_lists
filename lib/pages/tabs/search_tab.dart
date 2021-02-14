import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Game>>(
      future: _getGames(widget.search),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length + 1,
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
                          arguments: snapshot.data[index - 1]);
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
                              snapshot.data[index - 1].coverUrl,
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
                                    snapshot.data[index - 1].name,
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
        } else {
          return Container();
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  Future<List<Game>> _getGames(String name) async {
    if (name == "") {
      return widget.database.gameDao.findAllGames();
    } else {
      return widget.database.gameDao.findGamesByName('%$name%');
    }
  }
}
