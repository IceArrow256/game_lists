import 'dart:typed_data';

import 'package:floor/floor.dart';

@Entity(tableName: 'game')
class Game {
  @PrimaryKey(autoGenerate: true)
  final int id;

  @ColumnInfo(name: 'name', )
  final String name;

  @ColumnInfo(name: 'image')
  final Uint8List? image;

  @ColumnInfo(name: 'description')
  final String? description;

  Game(this.id, this.name, this.image, this.description);
}
