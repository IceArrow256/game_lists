import 'package:hive/hive.dart';

part 'genre.g.dart';

Future<Genre> saveGenre(rawGenre) async {
  var genreBox = await Hive.openBox<Genre>('genre');
  var genresInBox =
      genreBox.values.where((e) => e.giantBombId == rawGenre['id']);
  var genre = Genre(rawGenre['id'], rawGenre['name']);
  if (genresInBox.isEmpty) {
    genreBox.add(genre);
  } else {
    genre = genresInBox.first;
  }
  return genre;
}

Future<List<Genre>> saveGenres(rawGenre) async {
  var genres = <Genre>[];
  for (var rawGenre in rawGenre) {
    genres.add(await saveGenre(rawGenre));
  }
  return genres;
}

@HiveType(typeId: 3)
class Genre extends HiveObject {
  @HiveField(0)
  int giantBombId;
  @HiveField(1)
  String name;

  Genre(this.giantBombId, this.name);
}
