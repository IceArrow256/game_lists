import 'dart:typed_data';

import 'package:game_lists/model/developer.dart';
import 'package:game_lists/model/franchise.dart';
import 'package:game_lists/model/genre.dart';
import 'package:game_lists/model/platform.dart';
import 'package:hive/hive.dart';

part 'game.g.dart';

@HiveType(typeId: 0)
class Game extends HiveObject {
  @HiveField(0)
  int giantBombId;

  @HiveField(1)
  DateTime dateLastUpdated;

  @HiveField(2)
  String name;

  @HiveField(3)
  String imageUrl;

  @HiveField(4)
  String? description;

  @HiveField(5)
  DateTime? releaseDate;

  @HiveField(6)
  List<Developer> developers;

  @HiveField(7)
  List<Franchise> franchises;

  @HiveField(8)
  List<Genre> genres;

  @HiveField(9)
  List<Platform> platforms;

  Game(
    this.giantBombId,
    this.dateLastUpdated,
    this.name,
    this.imageUrl,
    this.description,
    this.releaseDate,
    this.developers,
    this.franchises,
    this.genres,
    this.platforms,
  );
}
