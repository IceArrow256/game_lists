import 'package:hive/hive.dart';

part 'platform.g.dart';

Future<Platform> savePlatform(rawPlatform) async {
  var platformBox = await Hive.openBox<Platform>('platform');
  var platformsInBox =
      platformBox.values.where((e) => e.giantBombId == rawPlatform['id']);
  var platform = Platform(
      rawPlatform['id'], rawPlatform['name'], rawPlatform['abbreviation']);
  if (platformsInBox.isEmpty) {
    platformBox.add(platform);
  } else {
    platform = platformsInBox.first;
  }
  return platform;
}

Future<List<Platform>> savePlatforms(rawPlatforms) async {
  var platforms = <Platform>[];
  for (var rawPlatform in rawPlatforms) {
    platforms.add(await savePlatform(rawPlatform));
  }
  return platforms;
}

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
