import 'package:floor/floor.dart';
import 'package:game_lists/database/entities/game_platform.dart';

@dao
abstract class GamePlatformDao {
  @insert
  Future<void> insertGamePlatform(GamePlatform gameReleaseDate);
}