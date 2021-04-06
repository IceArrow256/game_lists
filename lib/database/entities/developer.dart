import 'package:floor/floor.dart';
import 'package:game_lists/database/entities/country.dart';

@Entity(tableName: 'developer', foreignKeys: [
  ForeignKey(
    childColumns: ['country_id'],
    parentColumns: ['id'],
    entity: Country,
  )
])
class Developer {
  @PrimaryKey(autoGenerate: true)
  final int id;

  @ColumnInfo(name: 'country_id')
  final int? countryId;

  @ColumnInfo(name: 'name')
  final String? name;

  Developer(this.id, this.countryId, this.name);
}
