import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:game_list/db/dao/game_dao.dart';
import 'package:game_list/db/model/game.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 2, entities: [Game])
abstract class AppDatabase extends FloorDatabase {
  GameDao get gameDao;
}

final migration1to2 = Migration(1, 2, (database) async {
  await database.execute('ALTER TABLE game ADD COLUMN cover_url TEXT');
});
