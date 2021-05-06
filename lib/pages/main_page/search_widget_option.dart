import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:game_lists/model/developer.dart';
import 'package:game_lists/model/franchise.dart';
import 'package:game_lists/model/game.dart';
import 'package:game_lists/model/genre.dart';
import 'package:game_lists/model/platform.dart';
import 'package:game_lists/model/status.dart';
import 'package:game_lists/model/walkthrough.dart';
import 'package:game_lists/pages/add_edit_pages/game_in_list_page.dart';

class SearchGameCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final List<String> platforms;
  final String releaseDate;
  final VoidCallback onTap;
  const SearchGameCard(
      {Key? key,
      required this.imageUrl,
      required this.name,
      required this.platforms,
      required this.releaseDate,
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
                height: 128,
                width: 96,
                fit: BoxFit.fitHeight,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                child: Container(
                  height: 128,
                  width: MediaQuery.of(context).size.width - 136,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            platforms.join(', '),
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(releaseDate, style: TextStyle(fontSize: 14)),
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
                      itemBuilder: (context, index) {
                        var gameInSearch =
                            data.elementAt(index) as Map<String, dynamic>;
                        List<String> platforms = [];
                        for (var platform in gameInSearch['platforms']) {
                          platforms.add(platform['abbreviation']);
                        }
                        return SearchGameCard(
                          imageUrl: gameInSearch['imageUrl'],
                          name: gameInSearch['name'],
                          platforms: platforms,
                          releaseDate: gameInSearch['releaseDate'] ?? '',
                          onTap: () async {
                            var data = <String, dynamic>{};
                            await Dio()
                                .get(
                                  'http://192.168.0.2:8000/game/${gameInSearch['id']}',
                                )
                                .then((value) => data = value.data)
                                .catchError((e) {
                              print(e);
                            });
                            var game = Game(
                              data['id'],
                              DateTime.parse(data['dateLastUpdated']),
                              data['name'],
                              data['imageUrl'],
                              data['description'],
                              DateTime.parse(data['releaseDate']),
                              await saveDevelopers(data['developers']),
                              await saveFranchises(data['franchises']),
                              await saveGenres(data['genres']),
                              await savePlatforms(data['platforms']),
                              0,
                              '',
                              Status.playing,
                              [Walkthrough(startDate: DateTime.now())],
                            );
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
    var data = [];
    await Dio()
        .get(
          'http://192.168.0.2:8000/search',
          queryParameters: {'query': query},
        )
        .then((value) => data = value.data)
        .catchError((e) {
          print("error");
        });

    return data;
  }
}
