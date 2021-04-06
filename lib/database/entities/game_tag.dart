import 'package:floor/floor.dart';
import 'package:game_lists/database/entities/game.dart';
import 'package:game_lists/database/entities/tag.dart';

@Entity(tableName: 'game_tag', foreignKeys: [
  ForeignKey(
    childColumns: ['game_id'],
    parentColumns: ['id'],
    entity: Game,
  ),
  ForeignKey(
    childColumns: ['tag_id'],
    parentColumns: ['id'],
    entity: Tag,
  )
])
class GameTag {
  @PrimaryKey(autoGenerate: true)
  final int id;

  @ColumnInfo(name: 'game_id')
  final int gameId;

  @ColumnInfo(name: 'tag_id')
  final int tagId;

  GameTag(this.id, this.gameId, this.tagId);
}
