import 'package:flutter/material.dart';

import 'package:game_list/db/database.dart';
import 'package:game_list/db/model/game.dart';

class GamesTab extends StatefulWidget {
  @override
  _GamesTabState createState() => _GamesTabState();
}

class _GamesTabState extends State<GamesTab> {
  Future<AppDatabase> _database;

  Future<List<Game>> _getAllGame() async {
    final database = await _database;
    return database.gameDao.findAllGame();
  }

  @override
  void initState() {
    _database = $FloorAppDatabase
        .databaseBuilder('game_list.db')
        .addMigrations([migration1to2]).build();
    super.initState();
  }

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
                return SizedBox(height: 8);
              } else {
                return Card(
                  child: ListTile(
                    title: Text(snapshot.data[index - 1].name),
                    subtitle: Text(
                        'Release: 2020\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Cras ultricies vel tellus sit amet dictum. Donec vel ipsum fringilla sapien molestie eleifend. Aenean blandit aliquam lorem.'),
                    leading: Image.network(
                      snapshot.data[index - 1].coverUrl,
                    ),
                    onTap: () {},
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
}
