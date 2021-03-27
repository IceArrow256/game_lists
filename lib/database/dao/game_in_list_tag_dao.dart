import 'package:floor/floor.dart';
import 'package:game_lists/database/entities/game_in_list_tag.dart';

@dao
abstract class GameInListTagDao {
  @insert
  Future<void> insertGameInListTag(GameInListTag gameInListTag);
}