import 'package:hive/hive.dart';

part 'platform.g.dart';

@HiveType(typeId: 4)
class Platform extends HiveObject {
  @HiveField(0)
  int giantBombId;
  @HiveField(1)
  String name;
  @HiveField(2)
  String abbreviation;

  Platform(this.giantBombId, this.name, this.abbreviation);
}
