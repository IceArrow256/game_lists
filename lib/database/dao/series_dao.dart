import 'package:floor/floor.dart';
import 'package:game_lists/database/entities/series.dart';

@dao
abstract class SeriesDao {
  @insert
  Future<void> insertSeries(Series series);
}