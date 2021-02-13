import 'package:floor/floor.dart';
import 'package:game_list/db/model/game.dart';

@Entity(tableName: 'GameInList', foreignKeys: [
  ForeignKey(childColumns: ['game_id'], parentColumns: ['id'], entity: Game)
])
class GameInList {
  @PrimaryKey(autoGenerate: true)
  final int id;

  @ColumnInfo(name: 'game_id', nullable: false)
  final int gameId;

  @ColumnInfo(name: 'date_added', nullable: false)
  final DateTime dateAdded;

  GameInList(this.id, this.gameId, this.dateAdded);
}

// class Dog {
//   @PrimaryKey()
//   final int id;

//   final String name;

//   @ColumnInfo(name: 'owner_id')
//   final int ownerId;

//   Dog(this.id, this.name, this.ownerId);
// }
