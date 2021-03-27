import 'package:floor/floor.dart';
import 'package:game_lists/database/entities/game_tag.dart';

@dao
abstract class GameTagDao {
  @insert
  Future<void> insertGameTag(GameTag gameTag);
}