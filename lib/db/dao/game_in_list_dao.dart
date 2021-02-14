import 'package:floor/floor.dart';
import 'package:game_list/db/model/game_in_list.dart';

@dao
abstract class GameInListDao {
  @delete
  Future<int> deleteGamesInList(List<GameInList> gamesInList);

  @delete
  Future<void> deleteObject(GameInList gameInList);

  @Query('SELECT * FROM GameInList')
  Future<List<GameInList>> findAll();

  @Query('SELECT * FROM GameInList WHERE game_id = :id')
  Future<GameInList> findByGameId(int id);

  @insert
  Future<void> insertObject(GameInList gameInList);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateGameInList(GameInList gameInList);
}
