import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchWidgetOption extends StatefulWidget {
  @override
  _SearchWidgetOptionState createState() => _SearchWidgetOptionState();
}

class _SearchWidgetOptionState extends State<SearchWidgetOption> {
  var textEditingController = TextEditingController();
  Uri? _url;

  @override
  Widget build(BuildContext context) {
    _url = Uri.http(
        '192.168.0.2:8000', '/search', {'query': textEditingController.text});
    print(_url);
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
          FutureBuilder<http.Response>(
            future: http.get(_url!),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.body == "[]") {
                return Container();
              }
              if (snapshot.hasData && snapshot.data!.body != "[]") {
                print(convert.jsonDecode(snapshot.data!.body).runtimeType);
                var data =
                    convert.jsonDecode(snapshot.data!.body) as List<dynamic>;
                return Expanded(
                  child: Container(
                    child: ListView.builder(
                      padding: EdgeInsets.all(8),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        List<String> platforms = [];
                        for (var platform
                            in data.elementAt(index)['platforms']) {
                          platforms.add(platform['abbreviation']);
                        }
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(data.elementAt(index)['imageUrl'],
                                    height: 128,
                                    width: 91,
                                    fit: BoxFit.fitHeight),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                  child: Container(
                                    height: 128,
                                    width:
                                        MediaQuery.of(context).size.width - 155,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data.elementAt(index)['name'],
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            Text(
                                              platforms.join(', '),
                                              maxLines: null,
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          child: Text(
                                            data.elementAt(
                                                        index)['releaseDate'] ==
                                                    null
                                                ? ""
                                                : data.elementAt(
                                                    index)['releaseDate'],
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              }
              return Center();
            },
          )
        ],
      ),
    );
  }
}
