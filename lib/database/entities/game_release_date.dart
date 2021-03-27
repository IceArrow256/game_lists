import 'package:floor/floor.dart';
import 'package:game_lists/database/entities/game.dart';
import 'package:game_lists/database/entities/platform.dart';

@Entity(tableName: 'game_release_date', foreignKeys: [
  ForeignKey(
    childColumns: ['game_id'],
    parentColumns: ['id'],
    entity: Game,
  ),
  ForeignKey(
    childColumns: ['platform_id'],
    parentColumns: ['id'],
    entity: Platform,
  )
])
class GameReleaseDate {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  @ColumnInfo(name: 'date')
  final DateTime? date;

  @ColumnInfo(name: 'game_id')
  final int? gameId;

  @ColumnInfo(name: 'platform_id')
  final int? platformId;

  GameReleaseDate(this.id, this.date, this.gameId, this.platformId);
}
