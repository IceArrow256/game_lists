import 'package:hive/hive.dart';

part 'platform.g.dart';

@HiveType(typeId: 4)
class Platform extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String shortName;
  
  Platform(this.id, this.name, this.shortName);
}