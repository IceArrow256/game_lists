import 'dart:typed_data';

import 'package:floor/floor.dart';

@Entity(tableName: 'game')
class Game {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  @ColumnInfo(name: 'create_time')
  final DateTime? createTime;

  @ColumnInfo(name: 'description')
  final String? description;

  @ColumnInfo(name: 'image')
  final Uint8List? image;

  @ColumnInfo(name: 'name')
  final String? name;

  Game(this.id, this.description, this.name, this.image, {DateTime? createTime})
      : this.createTime = createTime ?? DateTime.now();
}
