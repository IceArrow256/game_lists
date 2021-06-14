import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:game_lists/model/developer.dart';
import 'package:game_lists/model/franchise.dart';
import 'package:game_lists/model/game.dart';
import 'package:game_lists/model/genre.dart';
import 'package:game_lists/model/platform.dart';
import 'package:game_lists/model/status.dart';
import 'package:game_lists/model/walkthrough.dart';
import 'package:game_lists/pages/game_in_list_page.dart';
import 'package:hive/hive.dart';

class GameInSearchCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String? releaseDate;
  final List<String> platforms;
  final String? description;
  final VoidCallback onTap;
  const GameInSearchCard(
      {Key? key,
      required this.imageUrl,
      required this.name,
      required this.releaseDate,
      required this.platforms,
      required this.description,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(4.0),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                imageUrl,
                width: 96,
                fit: BoxFit.fitHeight,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                child: Container(
                  width: MediaQuery.of(context).size.width - 136,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  releaseDate != null
                                      ? '$name (${releaseDate!.substring(0, 4)})'
                                      : name,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.blue.shade100),
                                ),
                              ),
                            ],
                          ),
                          Visibility(
                            visible: platforms.isNotEmpty,
                            child: Column(
                              children: [
                                SizedBox(height: 4),
                                Text(platforms.join(', '),
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(fontSize: 12)),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: description != null,
                            child: Column(
                              children: [
                                SizedBox(height: 4),
                                Text(
                                  description ?? '',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade300),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchWidgetOption extends StatefulWidget {
  @override
  _SearchWidgetOptionState createState() => _SearchWidgetOptionState();
}

class _SearchWidgetOptionState extends State<SearchWidgetOption> {
  var textEditingController = TextEditingController();
  Uri? _url;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          TextFormField(
            controller: textEditingController,
            autofocus: true,
            onChanged: (value) {
              setState(() {});
            },
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search for game to add...'),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
              child: FutureBuilder<List<dynamic>>(
                future: search(query: textEditingController.text),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var data = snapshot.data!;
                    return ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      itemCount: data.length,
                      itemBuilder: (context, i) {
                        var gameInSearch =
                            data.elementAt(i) as Map<String, dynamic>;
                        List<String> platforms = [];
                        for (var platform in gameInSearch['platforms']) {
                          platforms.add(platform['abbreviation']);
                        }
                        return GameInSearchCard(
                          imageUrl: gameInSearch['imageUrl'],
                          name: gameInSearch['name'],
                          releaseDate: gameInSearch['releaseDate'],
                          platforms: platforms,
                          description: gameInSearch['description'],
                          onTap: () async {
                            var hostBox = await Hive.openBox<String>('host');
                            var data = <String, dynamic>{};
                            await Dio()
                                .get(
                                  'http://${hostBox.get('host')}:8000/game/${gameInSearch['id']}',
                                )
                                .then((value) => data = value.data)
                                .catchError((e) {
                              print(e);
                            });
                            var gameBox = await Hive.openBox<Game>('game');
                            var games = gameBox.values
                                .where((element) =>
                                    element.giantBombId == data['id'])
                                .toList();
                            Game? game;
                            if (games.isEmpty) {
                              game = Game(
                                giantBombId: data['id'],
                                dateLastUpdated:
                                    DateTime.parse(data['dateLastUpdated']),
                                name: data['name'],
                                image: await getImageFromUrl(data['imageUrl']),
                                description: data['description'],
                                releaseDate: data['releaseDate'] != null
                                    ? DateTime.parse(data['releaseDate'])
                                    : null,
                                developers:
                                    await saveDevelopers(data['developers']),
                                franchises:
                                    await saveFranchises(data['franchises']),
                                genres: await saveGenres(data['genres']),
                                platforms:
                                    await savePlatforms(data['platforms']),
                                rating: 0,
                                notes: '',
                                status: Status.playing,
                                walkthroughs: [
                                  Walkthrough(startDate: DateTime.now())
                                ],
                              );
                            } else {
                              game = games.first;
                              game.dateLastUpdated =
                                  DateTime.parse(data['dateLastUpdated']);
                              game.name = data['name'];
                              game.image =
                                  await getImageFromUrl(data['imageUrl']);
                              game.description = data['description'];
                              game.releaseDate =
                                  DateTime.parse(data['releaseDate']);
                              game.developers =
                                  await saveDevelopers(data['developers']);
                              game.franchises =
                                  await saveFranchises(data['franchises']);
                              game.genres = await saveGenres(data['genres']);
                              game.platforms =
                                  await savePlatforms(data['platforms']);
                            }
                            Navigator.pushNamed(
                              context,
                              GameInListPage.routeName,
                              arguments: game,
                            );
                          },
                        );
                      },
                    );
                  }
                  return Center();
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<List<dynamic>> search({required String query}) async {
    var hostBox = await Hive.openBox<String>('host');
    var data = [];
    print('http://${hostBox.get('host')}/search');
    await Dio()
        .get(
          'http://${hostBox.get('host')}:8000/search',
          queryParameters: {'query': query},
        )
        .then((value) => data = value.data)
        .catchError((e) {
          print("error");
        });

    return data;
  }
}
