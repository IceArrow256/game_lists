import 'package:hive/hive.dart';

part 'company.g.dart';

@HiveType(typeId: 1)
class Company extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String country;

  Company(this.name, this.country);
}
