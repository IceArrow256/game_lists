import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class GameInListPage extends StatefulWidget {
  static const routeName = '/gameInListPage';
  @override
  _GameInListPageState createState() => _GameInListPageState();
}

class _GameInListPageState extends State<GameInListPage> {
  List<String> _statuses = [
    'Playing',
    'Planning',
    'Completed',
    'Pause',
    'Dropped',
  ];
  String _selectedStatus = 'Playing';
  double _currentRating = 0;

  @override
  Widget build(BuildContext context) {
    final int gameId = ModalRoute.of(context)!.settings.arguments as int;
    return FutureBuilder<Map<String, dynamic>>(
      future: getGame(id: gameId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var game = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: Text(game['name']),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    game['name'],
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Status:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      DropdownButton<String>(
                                          isExpanded: true,
                                          value: _selectedStatus,
                                          onChanged: (value) => setState(
                                              () => _selectedStatus = value!),
                                          items: _statuses
                                              .map((e) => DropdownMenuItem(
                                                    value: e,
                                                    child: Text(e),
                                                  ))
                                              .toList()),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Start Date:',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Row(
                            children: [
                              IconButton(
                                  icon: Icon(Icons.remove_circle),
                                  onPressed: () {}),
                              TextButton(
                                  onPressed: () async {
                                    var time = await showDatePicker(
                                        context: context,
                                        firstDate: DateTime(2020),
                                        initialDate: DateTime(2020),
                                        lastDate: DateTime(2021));
                                    print(time);
                                  },
                                  child: Text('2020-04-11'))
                            ],
                          ),
                        ],
                      ),
                      Container(height: 50, child: VerticalDivider()),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'End date:',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Row(
                            children: [
                              IconButton(
                                  icon: Icon(Icons.remove_circle),
                                  onPressed: () {}),
                              TextButton(
                                  onPressed: () async {
                                    var time = await showDatePicker(
                                        context: context,
                                        firstDate: DateTime(2020),
                                        initialDate: DateTime(2020),
                                        lastDate: DateTime(2021));
                                    print(time);
                                  },
                                  child: Text('2020-04-11'))
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  TextFormField(
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
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Text('Cancel'),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.grey, // background
                                  onPrimary: Colors.white, // foreground
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                              child: ElevatedButton(
                                  onPressed: () {}, child: Text('Save')),
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Delete'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red, // background
                          onPrimary: Colors.white, // foreground
                        ),
                      ),
                    ],
                  )
                ],
              ),
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
