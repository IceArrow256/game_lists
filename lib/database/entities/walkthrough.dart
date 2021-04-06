import 'package:floor/floor.dart';
import 'package:game_lists/database/entities/game_in_list.dart';

@Entity(tableName: 'walkthrough', foreignKeys: [
  ForeignKey(
    childColumns: ['game_in_list_id'],
    parentColumns: ['id'],
    entity: GameInList,
  )
])
class Walkthrough {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  @ColumnInfo(name: 'game_in_list_id')
  final int? gameInListId;

  @ColumnInfo(name: 'start')
  final DateTime? start;

  @ColumnInfo(name: 'end')
  final DateTime? end;

  @ColumnInfo(name: 'time_played')
  final int? timePlayed;

  Walkthrough(this.id, this.gameInListId, this.start, this.end, this.timePlayed);
}
