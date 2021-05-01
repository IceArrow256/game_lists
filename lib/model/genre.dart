import 'package:hive/hive.dart';

part 'genre.g.dart';

@HiveType(typeId: 3)
class Genre extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;

  Genre(this.id, this.name);
}
