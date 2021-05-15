import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:game_lists/model/developer.dart';
import 'package:game_lists/model/franchise.dart';
import 'package:game_lists/model/genre.dart';
import 'package:game_lists/model/platform.dart';
import 'package:game_lists/model/status.dart';
import 'package:game_lists/model/walkthrough.dart';
import 'package:hive/hive.dart';
import 'package:image/image.dart';

part 'game.g.dart';

void fixCountry(List<Game> games) async {
  games.forEach((game) {
    game.developers.forEach((developer) {
      if (developer.country == 'USA') developer.country = 'United States';
      if (developer.country == 'U.S.A') developer.country = 'United States';
      if (developer.country == 'P.R.C.') developer.country = 'China';
      if (developer.country == 'United States of America')
        developer.country = 'United States';
    });
  });
}

Future<Uint8List> getImageFromUrl(String url) async {
  print(url);
  Uint8List rawImage = Uint8List.fromList(
      (await Dio().get(url, options: Options(responseType: ResponseType.bytes)))
          .data);
  var image = decodeImage(rawImage)!;
  if (image.width > 1024) {
    var finalW = 1024;
    var finalH = ((finalW * image.height) / image.width).round();
    image = copyResize(image,
        width: finalW, height: finalH, interpolation: Interpolation.linear);
  }
  return Uint8List.fromList(encodePng(image));
}

@HiveType(typeId: 0)
class Game extends HiveObject {
  @HiveField(0)
  int? giantBombId;

  @HiveField(1)
  int? steamId;

  @HiveField(2)
  DateTime dateAdded;

  @HiveField(3)
  DateTime dateLastUpdated;

  @HiveField(4)
  String name;

  @HiveField(5)
  Uint8List? image;

  @HiveField(6)
  String? description;

  @HiveField(7)
  DateTime? releaseDate;

  @HiveField(8)
  List<Developer> developers;

  @HiveField(9)
  List<Franchise> franchises;

  @HiveField(10)
  List<Genre> genres;

  @HiveField(11)
  List<Platform> platforms;

  @HiveField(12)
  int rating;

  @HiveField(13)
  String notes;

  @HiveField(14)
  Status status;

  @HiveField(15)
  List<Walkthrough> walkthroughs;

  Game({
    this.giantBombId,
    this.steamId,
    required this.dateLastUpdated,
    required this.name,
    this.image,
    this.description,
    this.releaseDate,
    required this.developers,
    required this.franchises,
    required this.genres,
    required this.platforms,
    required this.rating,
    required this.notes,
    required this.status,
    required this.walkthroughs,
  }) : this.dateAdded = DateTime.now();
}
