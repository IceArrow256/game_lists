import 'package:hive/hive.dart';

part 'status.g.dart';

@HiveType(typeId: 6)
enum Status {
  @HiveField(0)
  playing,
  @HiveField(1)
  planning,
  @HiveField(2)
  completed,
  @HiveField(3)
  pause,
  @HiveField(4)
  dropped,
}
