import 'dart:typed_data';

import 'package:floor/floor.dart';

@Entity(tableName: 'platform')
class Platform {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  @ColumnInfo(name: 'create_time')
  final DateTime? createTime;

  @ColumnInfo(name: 'image')
  final Uint8List? image;

  @ColumnInfo(name: 'name')
  final String? name;

  Platform(this.id, this.image, this.name, {DateTime? createTime}) : this.createTime = createTime ?? DateTime.now();
}
