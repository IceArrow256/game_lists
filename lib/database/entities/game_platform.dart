import 'package:floor/floor.dart';
import 'package:game_lists/database/entities/game.dart';
import 'package:game_lists/database/entities/platform.dart';

@Entity(tableName: 'game_platform', foreignKeys: [
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
class GamePlatform {
  @PrimaryKey(autoGenerate: true)
  final int id;

  @ColumnInfo(name: 'game_id')
  final int gameId;

  @ColumnInfo(name: 'platform_id')
  final int platformId;

  @ColumnInfo(name: 'date')
  final DateTime date;

  GamePlatform(this.id, this.gameId, this.platformId, this.date);
}
