import 'package:floor/floor.dart';

@Entity(tableName: 'series')
class Series {
  @PrimaryKey(autoGenerate: true)
  final int id;

  @ColumnInfo(name: 'name')
  final String name;

  Series(this.id, this.name);
}
