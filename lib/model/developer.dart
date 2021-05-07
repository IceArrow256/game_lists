import 'package:hive/hive.dart';

part 'developer.g.dart';

Future<Developer> saveDeveloper(rawDeveloper) async {
  var developerBox = await Hive.openBox<Developer>('developer');
  var developersInBox =
      developerBox.values.where((e) => e.giantBombId == rawDeveloper['id']);
  var developer = Developer(
    rawDeveloper['id'],
    DateTime.parse(rawDeveloper['dateLastUpdated']),
    rawDeveloper['name'],
    rawDeveloper['country'],
  );
  if (developersInBox.isEmpty) {
    developerBox.add(developer);
  } else {
    developer = developersInBox.first;
  }
  return developer;
}

Future<List<Developer>> saveDevelopers(rawDevelopers) async {
  var developers = <Developer>[];
  for (var rawDeveloper in rawDevelopers) {
    developers.add(await saveDeveloper(rawDeveloper));
  }
  return developers;
}

@HiveType(typeId: 1)
class Developer extends HiveObject {
  @HiveField(0)
  int? giantBombId;
  @HiveField(1)
  DateTime dateLastUpdated;
  @HiveField(2)
  String name;
  @HiveField(3)
  String? country;

  Developer(this.giantBombId, this.dateLastUpdated, this.name, this.country);
}
