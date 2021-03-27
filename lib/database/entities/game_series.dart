import 'package:floor/floor.dart';
import 'package:game_lists/database/entities/game.dart';
import 'package:game_lists/database/entities/series.dart';

@Entity(
  tableName: 'game_series',
  foreignKeys: [
    ForeignKey(
      childColumns: ['game_id'],
      parentColumns: ['id'],
      entity: Game,
    ),
    ForeignKey(
      childColumns: ['series_id'],
      parentColumns: ['id'],
      entity: Series,
    )
  ],
)
class GameSeries {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  @ColumnInfo(name: 'game_id')
  final int? gameId;

  @ColumnInfo(name: 'series_id')
  final int? seriesId;

  GameSeries(this.id, this.gameId, this.seriesId);
}
