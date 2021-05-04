import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateRange {
  DateTime? start;

  DateTime? end;
  DateRange({this.start, this.end});
}

class GameInListPage extends StatefulWidget {
  static const routeName = '/gameInListPage';
  @override
  _GameInListPageState createState() => _GameInListPageState();
}

class WalkthroughWidget extends StatefulWidget {
  Map<String, DateTime?> walkthrough = {};
  final DateTime firstDate;
  WalkthroughWidget({
    Key? key,
    required this.firstDate,
  }) : super(key: key);

  @override
  _WalkthroughWidgetState createState() => _WalkthroughWidgetState();

  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
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
  var walkthroughWidgets = <WalkthroughWidget>[];
  var noteTextEditingController = TextEditingController();

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
                                print(game);
                                print(_selectedStatus);
                                print(_currentRating);
                                print(walkthroughWidgets
                                    .map((e) => e.walkthrough)
                                    .toList());
                                print(noteTextEditingController.text);
                                Navigator.pop(context);
                              },
                              child: Text('Save')),
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
                  initialDate:
                      widget.walkthrough['startDate'] ?? DateTime.now(),
                  firstDate: widget.firstDate,
                  lastDate: DateTime.now());
              setState(() {
                widget.walkthrough['startDate'] =
                    date ?? widget.walkthrough['startDate'];
                if (widget.walkthrough['endDate'] != null &&
                    widget.walkthrough['endDate']!
                            .compareTo(widget.walkthrough['startDate']!) <
                        0) {
                  widget.walkthrough['endDate'] = null;
                }
              });
            },
            child: Text(
              'Start Date: ${widget.walkthrough['startDate'] != null ? formatter.format(widget.walkthrough['startDate']!) : 'Tap To Set'}',
            )),
        TextButton(
            onPressed: () async {
              var date = await showDatePicker(
                  context: context,
                  initialDate: widget.walkthrough['endDate'] ?? DateTime.now(),
                  firstDate:
                      widget.walkthrough['startDate'] ?? widget.firstDate,
                  lastDate: DateTime.now());
              setState(() {
                widget.walkthrough['endDate'] =
                    date ?? widget.walkthrough['endDate'];
              });
            },
            child: Text(
              'End Date: ${widget.walkthrough['endDate'] != null ? formatter.format(widget.walkthrough['endDate']!) : 'Tap To Set'}',
            )),
      ],
    );
  }

  @override
  void initState() {
    if (!widget.walkthrough.containsKey('startDate')) {
      widget.walkthrough['startDate'] = DateTime.now();
    }
    if (!widget.walkthrough.containsKey('endDate')) {
      widget.walkthrough['endDate'] = null;
    }
    super.initState();
  }
}
