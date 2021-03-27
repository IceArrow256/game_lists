import 'package:floor/floor.dart';

@Entity(tableName: 'tag')
class Tag {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  @ColumnInfo(name: 'name')
  final String? name;

  Tag(this.id, this.name);
}
