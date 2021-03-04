import 'package:floor/floor.dart';
import 'package:game_list/db/model/game.dart';

enum Status { inbox, playing, paused, completed, dropped }

@Entity(tableName: 'GameInList', foreignKeys: [
  ForeignKey(childColumns: ['game_id'], parentColumns: ['id'], entity: Game),
], indices: [
  Index(value: ['game_id'], unique: true)
])
class GameInList {
  @PrimaryKey(autoGenerate: true)
  final int id;

  @ColumnInfo(name: 'game_id', nullable: false)
  final int gameId;

  @ColumnInfo(name: 'date_added', nullable: false)
  final DateTime dateAdded;

  @ColumnInfo(nullable: false)
  final Status status;

  GameInList(this.id, this.gameId, this.dateAdded, this.status);
}
