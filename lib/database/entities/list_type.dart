import 'package:floor/floor.dart';

@Entity(tableName: 'list_type')
class ListType {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  @ColumnInfo(name: 'name')
  final String? name;

  ListType(this.id, this.name);
}
