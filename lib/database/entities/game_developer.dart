import 'package:floor/floor.dart';
import 'package:game_lists/database/entities/developer.dart';
import 'package:game_lists/database/entities/game.dart';

@Entity(tableName: 'game_developer', foreignKeys: [
  ForeignKey(
    childColumns: ['game_id'],
    parentColumns: ['id'],
    entity: Game,
  ),
  ForeignKey(
    childColumns: ['developer_id'],
    parentColumns: ['id'],
    entity: Developer,
  )
])
class GameDeveloper {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  @ColumnInfo(name: 'developer_id')
  final int? developerId;

  @ColumnInfo(name: 'game_id')
  final DateTime? gameId;

  GameDeveloper(this.id, this.gameId, this.developerId);
}
