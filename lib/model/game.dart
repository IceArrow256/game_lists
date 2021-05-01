import 'dart:typed_data';

import 'package:game_lists/model/company.dart';
import 'package:game_lists/model/franchise.dart';
import 'package:game_lists/model/genre.dart';
import 'package:game_lists/model/release.dart';
import 'package:hive/hive.dart';

part 'game.g.dart';

@HiveType(typeId: 0)
class Game extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  Uint8List? image;

  @HiveField(3)
  List<Genre> genres;

  @HiveField(4)
  String? description;

  @HiveField(5)
  List<Release> releases;

  @HiveField(6)
  List<Franchise> franchises;
  
  Game(this.id, this.name, this.image, this.genres, this.description, this.releases, this.franchises);
}
