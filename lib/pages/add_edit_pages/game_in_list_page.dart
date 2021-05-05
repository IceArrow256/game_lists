import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:game_lists/model/developer.dart';
import 'package:game_lists/model/franchise.dart';
import 'package:game_lists/model/game.dart';
import 'package:game_lists/model/game_in_list.dart';
import 'package:game_lists/model/genre.dart';
import 'package:game_lists/model/platform.dart';
import 'package:game_lists/model/status.dart';
import 'package:game_lists/model/walkthrough.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class DateRange {
  DateTime? start;

  DateTime? end;
  DateRange({this.start, this.end});
}

class StatusName {
  Status status;

  String name;
  StatusName(this.status, this.name);
}

class GameInListPage extends StatefulWidget {
  static const routeName = '/gameInListPage';
  @override
  _GameInListPageState createState() => _GameInListPageState();
}

class WalkthroughWidget extends StatefulWidget {
  Walkthrough walkthrough;
  final DateTime firstDate;
  WalkthroughWidget({
    Key? key,
    required this.firstDate,
    Walkthrough? walkthrough,
  })  : this.walkthrough = walkthrough ?? Walkthrough(),
        super(key: key);

  @override
  _WalkthroughWidgetState createState() => _WalkthroughWidgetState();

  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _GameInListPageState extends State<GameInListPage> {
  List<StatusName> _statuses = [
    StatusName(Status.playing, 'Playing'),
    StatusName(Status.planning, 'Planning'),
    StatusName(Status.completed, 'Completed'),
    StatusName(Status.pause, 'Pause'),
    StatusName(Status.dropped, 'Dropped'),
  ];
  StatusName? _selectedStatus;
  double _currentRating = 0;
  var walkthroughWidgets = <WalkthroughWidget>[];
  var noteTextEditingController = TextEditingController();

  Future<List<Platform>> savePlatforms(rawPlatforms) async {
    var platforms = <Platform>[];
    for (var rawPlatform in rawPlatforms) {
      platforms.add(await savePlatform(rawPlatform));
    }
    return platforms;
  }

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

  Future<List<Franchise>> saveFranchises(rawFranchises) async {
    var franchises = <Franchise>[];
    for (var rawFranchise in rawFranchises) {
      franchises.add(await saveFranchise(rawFranchise));
    }
    return franchises;
  }

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

  Future<List<Genre>> saveGenres(rawGenre) async {
    var genres = <Genre>[];
    for (var rawGenre in rawGenre) {
      genres.add(await saveGenre(rawGenre));
    }
    return genres;
  }

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

  Future<List<Developer>> saveDevelopers(rawDevelopers) async {
    var developers = <Developer>[];
    for (var rawDeveloper in rawDevelopers) {
      developers.add(await saveDeveloper(rawDeveloper));
    }
    return developers;
  }

  Future<Developer> saveDeveloper(rawDeveloper) async {
    var developerBox = await Hive.openBox<Developer>('developer');
    var developersInBox =
        developerBox.values.where((e) => e.giantBombId == rawDeveloper['id']);
    var developer = Developer(
        rawDeveloper['id'],
        DateTime.parse(rawDeveloper['dateLastUpdated']),
        rawDeveloper['name'],
        rawDeveloper['country']);
    if (developersInBox.isEmpty) {
      developerBox.add(developer);
    } else {
      developer = developersInBox.first;
    }
    return developer;
  }

  Future<Game> saveGame(rawGame) async {
    var gameBox = await Hive.openBox<Game>('game');
    var gamesInBox =
        gameBox.values.where((e) => e.giantBombId == rawGame['id']);
    var game = Game(
        rawGame['id'],
        DateTime.parse(rawGame['dateLastUpdated']),
        rawGame['name'],
        rawGame['imageUrl'],
        rawGame['description'],
        DateTime.parse(rawGame['releaseDate']),
        await saveDevelopers(rawGame['developers']),
        await saveFranchises(rawGame['franchises']),
        await saveGenres(rawGame['genres']),
        await savePlatforms(rawGame['platforms']));
    if (gamesInBox.isEmpty) {
      await gameBox.add(game);
    } else {
      game = gamesInBox.first;
    }
    return game;
  }

  Future<Map<String, dynamic>> getMapFromGame(Game game) async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    var gameData = <String, dynamic>{};
    gameData['key'] = game.key;
    gameData['id'] = game.giantBombId;
    gameData['dateLastUpdated'] = game.dateLastUpdated.toIso8601String();
    gameData['name'] = game.name;
    gameData['imageUrl'] = game.imageUrl;
    gameData['description'] = game.description;
    gameData['releaseDate'] = formatter.format(game.releaseDate!);
    gameData['developers'] = game.developers.map((e) => {
          'key': e.key,
          'id': e.giantBombId,
          'name': e.name,
          'country': e.country,
        });
    gameData['franchises'] = game.franchises.map((e) => {
          'key': e.key,
          'id': e.giantBombId,
          'name': e.name,
        });
    gameData['genres'] = game.genres.map((e) => {
          'key': e.key,
          'id': e.giantBombId,
          'name': e.name,
        });
    gameData['platforms'] = game.platforms.map((e) => {
          'key': e.key,
          'id': e.giantBombId,
          'name': e.name,
          'abbreviation': e.abbreviation,
        });
    return gameData;
  }

  void save(Map<String, dynamic> gameData) async {
    var game = await saveGame(gameData);
    var gameInListBox = await Hive.openBox<GameInList>('gameInList');
    var gameInListsBox = gameInListBox.values.where((e) => e.game == game);
    var gameInList = GameInList(
        game,
        _currentRating.toInt(),
        noteTextEditingController.text,
        _selectedStatus != null
            ? _selectedStatus!.status
            : _statuses.first.status,
        walkthroughWidgets.map((e) => e.walkthrough).toList());
    if (gameInListsBox.isEmpty) {
      await gameInListBox.add(gameInList);
    } else {
      gameInList = gameInListsBox.first;
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final int gameId = ModalRoute.of(context)!.settings.arguments as int;
    return FutureBuilder<Map<String, dynamic>>(
      future: getGame(id: gameId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var game = snapshot.data!;
          var releaseDate = DateTime.parse(game['releaseDate']);
          if (walkthroughWidgets.isEmpty) {
            walkthroughWidgets.add(WalkthroughWidget(
              firstDate: releaseDate,
            ));
          }
          return Scaffold(
            appBar: AppBar(
              title: Text(game['name']),
            ),
            body: ListView(
              padding: const EdgeInsets.all(8.0),
              children: [
                Row(
                  children: [
                    Image.network(
                      game['imageUrl'],
                      height: 160,
                      width: 120,
                      fit: BoxFit.fitHeight,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                        child: Container(
                          height: 160,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  game['name'],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Status:',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    DropdownButton<StatusName>(
                                        isExpanded: true,
                                        value:
                                            _selectedStatus ?? _statuses.first,
                                        onChanged: (value) => setState(
                                            () => _selectedStatus = value!),
                                        items: _statuses
                                            .map((e) => DropdownMenuItem(
                                                value: e, child: Text(e.name)))
                                            .toList())
                                  ],
                                ),
                              ]),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  'Rating:',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 0, 0, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${_currentRating.round()}',
                        style: TextStyle(fontSize: 16),
                      ),
                      Expanded(
                        child: Slider(
                          value: _currentRating * 10,
                          min: 0,
                          max: 100,
                          divisions: 10,
                          label: _currentRating.round().toString(),
                          onChanged: (double value) {
                            setState(() {
                              _currentRating = value / 10;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: walkthroughWidgets,
                ),
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            walkthroughWidgets.add(WalkthroughWidget(
                              firstDate: releaseDate,
                            ));
                          });
                        },
                        child: Text("Add Walkthrough")),
                    SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red, // background
                            onPrimary: Colors.white, // foreground
                          ),
                          onPressed: () {
                            if (walkthroughWidgets.length > 1) {
                              setState(() {
                                walkthroughWidgets.removeLast();
                              });
                            }
                          },
                          child: Text("Delete Last Walkthrough")),
                    ),
                  ],
                ),
                TextFormField(
                  controller: noteTextEditingController,
                  decoration: InputDecoration(labelText: 'Notes'),
                ),
                SizedBox(
                  height: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Cancel'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.grey, // background
                              onPrimary: Colors.white, // foreground
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              save(game);
                            },
                            child: Text('Save'),
                          ),
                        ),
                      ],
                    ),
                    // ElevatedButton(
                    //   onPressed: () {},
                    //   child: Text('Delete'),
                    //   style: ElevatedButton.styleFrom(
                    //     primary: Colors.red, // background
                    //     onPrimary: Colors.white, // foreground
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          );
        }
        return Scaffold();
      },
    );
  }

  Future<Map<String, dynamic>> getGame({required int id}) async {
    var data = <String, dynamic>{};
    await Dio()
        .get(
          'http://192.168.0.2:8000/game/$id',
        )
        .then((value) => data = value.data)
        .catchError((e) {
      print(e);
    });

    return data;
  }
}

class _WalkthroughWidgetState extends State<WalkthroughWidget> {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
            onPressed: () async {
              var date = await showDatePicker(
                  context: context,
                  initialDate: widget.walkthrough.startDate ?? DateTime.now(),
                  firstDate: widget.firstDate,
                  lastDate: DateTime.now());
              setState(() {
                widget.walkthrough.startDate =
                    date ?? widget.walkthrough.startDate;
                if (widget.walkthrough.endDate != null &&
                    widget.walkthrough.endDate!
                            .compareTo(widget.walkthrough.startDate!) <
                        0) {
                  widget.walkthrough.endDate = null;
                }
              });
            },
            child: Text(
              'Start Date: ${widget.walkthrough.startDate != null ? formatter.format(widget.walkthrough.startDate!) : 'Tap To Set'}',
            )),
        TextButton(
            onPressed: () async {
              var date = await showDatePicker(
                  context: context,
                  initialDate: widget.walkthrough.endDate ?? DateTime.now(),
                  firstDate: widget.walkthrough.startDate ?? widget.firstDate,
                  lastDate: DateTime.now());
              setState(() {
                widget.walkthrough.endDate = date ?? widget.walkthrough.endDate;
              });
            },
            child: Text(
              'End Date: ${widget.walkthrough.endDate != null ? formatter.format(widget.walkthrough.endDate!) : 'Tap To Set'}',
            )),
      ],
    );
  }
}
