import 'package:floor/floor.dart';
import 'package:game_lists/database/entities/game_in_list.dart';

@dao
abstract class GameInListDao {
  @insert
  Future<void> insertGameInList(GameInList gameInList);
}