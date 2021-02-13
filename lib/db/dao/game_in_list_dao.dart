import 'package:floor/floor.dart';

import 'package:game_list/db/model/game_in_list.dart';

@dao
abstract class GameInListDao {
  @Query('SELECT * FROM GameInList')
  Future<List<GameInList>> findAllGamesInList();

  @Query('SELECT * FROM GameInList WHERE id = :id')
  Stream<GameInList> findGameById(int id);

  @insert
  Future<void> insertGameInList(GameInList gameInList);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateGameInList(GameInList gameInList);

  @delete
  Future<void> deleteGameInList(GameInList gameInList);

  @delete
  Future<int> deleteGamesInList(List<GameInList> gamesInList);
}
