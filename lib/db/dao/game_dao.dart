import 'package:floor/floor.dart';

import 'package:game_list/db/model/game.dart';

@dao
abstract class GameDao {
  @Query('SELECT * FROM Game')
  Future<List<Game>> findAllGame();

  @Query('SELECT * FROM Game WHERE id = :id')
  Stream<Game> findGameById(int id);

  @insert
  Future<void> insertGame(Game game);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateGame(Game game);

  @delete
  Future<void> deleteGame(Game game);

  @delete
  Future<int> deleteGames(List<Game> games);
}
