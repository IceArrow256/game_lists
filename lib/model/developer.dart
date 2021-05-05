import 'package:hive/hive.dart';

part 'developer.g.dart';

@HiveType(typeId: 1)
class Developer extends HiveObject {
  @HiveField(0)
  int giantBombId;
  @HiveField(1)
  DateTime dateLastUpdated;
  @HiveField(2)
  String name;
  @HiveField(3)
  String? country;

  Developer(this.giantBombId, this.dateLastUpdated, this.name, this.country);
}
