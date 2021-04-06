import 'package:floor/floor.dart';

@Entity(tableName: 'platform')
class Platform {
  @PrimaryKey(autoGenerate: true)
  final int id;

  @ColumnInfo(name: 'name')
  final String name;

  Platform(this.id, this.name);
}
