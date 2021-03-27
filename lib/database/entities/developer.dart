import 'dart:typed_data';

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
  final int? id;

  @ColumnInfo(name: 'create_time')
  final DateTime? createTime;

  @ColumnInfo(name: 'country_id')
  final int? countryId;

  @ColumnInfo(name: 'image')
  final Uint8List? image;

  @ColumnInfo(name: 'name')
  final String? name;

  Developer(this.id, this.countryId, this.name, this.image,
      {DateTime? createTime})
      : this.createTime = createTime ?? DateTime.now();
}
