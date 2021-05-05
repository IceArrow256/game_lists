import 'package:hive/hive.dart';

part 'genre.g.dart';

@HiveType(typeId: 3)
class Genre extends HiveObject {
  @HiveField(0)
  int giantBombId;
  @HiveField(1)
  String name;

  Genre(this.giantBombId, this.name);
}
