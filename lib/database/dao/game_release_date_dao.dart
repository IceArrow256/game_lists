import 'package:floor/floor.dart';
import 'package:game_lists/database/entities/game_release_date.dart';

@dao
abstract class GameReleaseDateDao {
  @insert
  Future<void> insertGameReleaseDate(GameReleaseDate gameReleaseDate);
}