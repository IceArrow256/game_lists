import 'package:hive/hive.dart';

part 'franchise.g.dart';

Future<Franchise> saveFranchise(rawFranchise) async {
  var franchiseBox = await Hive.openBox<Franchise>('franchise');
  var franchisesInBox =
      franchiseBox.values.where((e) => e.giantBombId == rawFranchise['id']);
  var franchise = Franchise(rawFranchise['id'], rawFranchise['name']);
  if (franchisesInBox.isEmpty) {
    franchiseBox.add(franchise);
  } else {
    franchise = franchisesInBox.first;
  }
  return franchise;
}

Future<List<Franchise>> saveFranchises(rawFranchises) async {
  var franchises = <Franchise>[];
  for (var rawFranchise in rawFranchises) {
    franchises.add(await saveFranchise(rawFranchise));
  }
  return franchises;
}

@HiveType(typeId: 2)
class Franchise extends HiveObject {
  @HiveField(0)
  int? giantBombId;
  @HiveField(1)
  String name;
  Franchise(this.giantBombId, this.name);
}
