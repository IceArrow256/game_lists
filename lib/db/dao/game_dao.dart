import 'package:floor/floor.dart';
import 'package:game_list/db/model/game.dart';

@dao
abstract class GameDao {
  @delete
  Future<void> deleteGame(Game game);

  @delete
  Future<int> deleteGames(List<Game> games);

  @Query('SELECT * FROM Game ORDER BY name ASC')
  Stream<List<Game>> findAllAsStream();

  @Query('SELECT * FROM Game WHERE name LIKE :name ORDER BY name ASC')
  Stream<List<Game>> findAllAsStreamByName(String name);

  @Query('SELECT * FROM Game ORDER BY name ASC')
  Future<List<Game>> findAllGames();

  @Query('SELECT * FROM Game WHERE id = :id')
  Future<Game> findById(int id);

  @insert
  Future<void> insertObject(Game game);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateGame(Game game);
}
