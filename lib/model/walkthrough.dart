import 'package:hive/hive.dart';

part 'walkthrough.g.dart';

@HiveType(typeId: 7)
class Walkthrough extends HiveObject {
  @HiveField(0)
  DateTime? startDate;

  @HiveField(1)
  DateTime? endDate;

  Walkthrough({this.startDate, this.endDate});
}
