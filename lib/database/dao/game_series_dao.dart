import 'package:floor/floor.dart';
import 'package:game_lists/database/entities/game_series.dart';

@dao
abstract class GameSeriesDao {
  @insert
  Future<void> insertGameSeries(GameSeries gameSeries);
}