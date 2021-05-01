import 'package:game_lists/model/company.dart';
import 'package:game_lists/model/platform.dart';
import 'package:hive/hive.dart';

part 'release.g.dart';

@HiveType(typeId: 5)
class Release extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  DateTime releaseDate;
  @HiveField(2)
  List<Company> developers;
  @HiveField(3)
  Platform platform;

  Release(this.id, this.releaseDate, this.developers, this.platform);
}
