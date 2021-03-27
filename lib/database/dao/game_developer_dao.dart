import 'package:floor/floor.dart';
import 'package:game_lists/database/entities/game_developer.dart';

@dao
abstract class GameDeveloperDao {
  @insert
  Future<void> insertCountry(GameDeveloper gameDeveloper);
}