import 'package:floor/floor.dart';

@Entity(tableName: 'country')
class Country {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  @ColumnInfo(name: 'name')
  final String name;

  Country(this.id, this.name);
}
