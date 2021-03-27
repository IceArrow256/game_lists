import 'package:floor/floor.dart';
import 'package:game_lists/database/entities/game.dart';
import 'package:game_lists/database/entities/list_type.dart';

@Entity(tableName: 'game_in_list', foreignKeys: [
  ForeignKey(
    childColumns: ['list_type_id'],
    parentColumns: ['id'],
    entity: ListType,
  ),
  ForeignKey(
    childColumns: ['game_id'],
    parentColumns: ['id'],
    entity: Game,
  )
])
class GameInList {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  @ColumnInfo(name: 'list_type_id')
  final int? listTypeId;

  @ColumnInfo(name: 'game_id')
  final int? gameId;

  @ColumnInfo(name: 'create_time')
  final DateTime? createTime;

  @ColumnInfo(name: 'score')
  final int? score;

  @ColumnInfo(name: 'notes')
  final String? notes;

  GameInList(this.id, this.listTypeId, this.gameId, this.score, this.notes,
      {DateTime? createTime})
      : this.createTime = createTime ?? DateTime.now();
}
