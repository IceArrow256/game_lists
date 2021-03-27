import 'package:floor/floor.dart';
import 'package:game_lists/database/entities/game.dart';

@dao
abstract class GameDao {
  @insert
  Future<void> insertGame(Game game);
}