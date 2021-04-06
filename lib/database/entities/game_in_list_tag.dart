import 'package:floor/floor.dart';
import 'package:game_lists/database/entities/game_in_list.dart';
import 'package:game_lists/database/entities/tag.dart';

@Entity(tableName: 'game_in_list_tag', foreignKeys: [
  ForeignKey(
    childColumns: ['game_in_list_id'],
    parentColumns: ['id'],
    entity: GameInList,
  ),
  ForeignKey(
    childColumns: ['tag_id'],
    parentColumns: ['id'],
    entity: Tag,
  )
])
class GameInListTag {
  @PrimaryKey(autoGenerate: true)
  final int id;

  @ColumnInfo(name: 'game_in_list_id')
  final int gameInListId;

  @ColumnInfo(name: 'tag_id')
  final int tagId;

  GameInListTag(this.id, this.gameInListId, this.tagId);
}
