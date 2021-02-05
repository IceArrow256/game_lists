import 'package:floor/floor.dart';

@entity
class Game {
  @PrimaryKey(autoGenerate: true)
  final int id;

  @ColumnInfo(nullable: false)
  final String name;

  @ColumnInfo(name: 'cover_url')
  final String coverUrl;

  Game(this.id, this.name, this.coverUrl);
}
