import 'dart:async';

import 'package:floor/floor.dart';
import 'package:game_list/db/dao/game_dao.dart';
import 'package:game_list/db/dao/game_in_list_dao.dart';
import 'package:game_list/db/model/game.dart';
import 'package:game_list/db/model/game_in_list.dart';
import 'package:game_list/db/type_converter/type_converter.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart'; // the generated code will be there

final migration1to2 = Migration(1, 2, (database) async {
  await database.execute('ALTER TABLE game ADD COLUMN cover_url TEXT');
});

@TypeConverters([DateTimeConverter])
@Database(version: 2, entities: [Game, GameInList])
abstract class AppDatabase extends FloorDatabase {
  GameDao get gameDao;
  GameInListDao get gameInListDao;
}
