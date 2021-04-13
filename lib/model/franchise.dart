import 'package:hive/hive.dart';

part 'franchise.g.dart';

@HiveType(typeId: 2)
class Franchise extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  Franchise(this.id, this.name); 
}