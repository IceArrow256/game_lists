import 'package:flutter/material.dart';
import 'package:game_list/db/database.dart';
import 'package:game_list/db/model/game.dart';
import 'package:game_list/pages/game/game_view.dart';

class SearchTab extends StatefulWidget {
  @override
  const SearchTab({Key key}) : super(key: key);

  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final Future<AppDatabase> _database = $FloorAppDatabase
      .databaseBuilder('game_list.db')
      .addMigrations([migration1to2]).build();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Game>>(
      future: _getAllGame(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return SizedBox(height: 4);
              } else {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: ListTile(
                    title: Text(snapshot.data[index - 1].name),
                    subtitle: Text('Release: 2020\nAvg Rating: 9.99'),
                    leading: CircleAvatar(
                      backgroundImage: Image.network(
                        snapshot.data[index - 1].coverUrl,
                      ).image,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, GameView.routeName,
                          arguments: snapshot.data[index - 1]);
                    },
                    isThreeLine: true,
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

  Future<List<Game>> _getAllGame() async {
    final database = await _database;
    return database.gameDao.findAllGame();
  }
}
