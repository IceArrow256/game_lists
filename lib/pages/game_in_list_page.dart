import 'package:flutter/material.dart';
import 'package:game_lists/model/game.dart';
import 'package:game_lists/model/status.dart';
import 'package:game_lists/model/walkthrough.dart';
import 'package:game_lists/pages/game_page.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class GameInListPage extends StatefulWidget {
  static const routeName = '/gameInListPage';
  @override
  _GameInListPageState createState() => _GameInListPageState();
}

class StatusName {
  Status status;

  String name;
  StatusName(this.status, this.name);
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
  var _noteTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final game = ModalRoute.of(context)!.settings.arguments as Game;
    return Scaffold(
      appBar: AppBar(
        title: Text(game.name),
        actions: [
          IconButton(
              icon: Icon(Icons.info),
              onPressed: () async {
                await Navigator.pushNamed(context, GamePage.routeName,
                    arguments: game);
              })
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          Image.memory(
            game.image!,
            height: 256,
            // fit: BoxFit.none,
            // cacheHeight: 256,
          ),
          Text(
            'Status:',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: DropdownButton<StatusName>(
                isExpanded: true,
                value: _selectedStatus ?? _statuses.first,
                onChanged: (value) => setState(() => _selectedStatus = value!),
                items: _statuses
                    .map((e) => DropdownMenuItem(value: e, child: Text(e.name)))
                    .toList()),
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
                        firstDate: game.releaseDate!,
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
            maxLines: null,
            controller: _noteTextEditingController,
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
                      onPressed: () async {
                        var gameBox = await Hive.openBox<Game>('game');
                        var gamesInBox = gameBox.values
                            .where((e) => e.giantBombId == game.giantBombId);
                        game.rating = _currentRating.toInt();
                        game.status = _selectedStatus!.status;
                        game.notes = _noteTextEditingController.text;
                        game.walkthroughs = walkthroughWidgets
                            .map((e) => e.walkthrough)
                            .toList();
                        if (gamesInBox.isEmpty) {
                          await gameBox.add(game);
                        } else {
                          await gameBox.put(gamesInBox.first.key, game);
                        }
                        Navigator.pop(context);
                      },
                      child: Text('Save'),
                    ),
                  ),
                ],
              ),
              game.key != null
                  ? ElevatedButton(
                      onPressed: () async {
                        var gameBox = await Hive.openBox<Game>('game');
                        var gamesInBox = gameBox.values
                            .where((e) => e.giantBombId == game.giantBombId);
                        if (gamesInBox.isNotEmpty) {
                          await gameBox.delete(gamesInBox.first.key);
                        }
                        Navigator.pop(context);
                      },
                      child: Text('Delete'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red, // background
                        onPrimary: Colors.white, // foreground
                      ),
                    )
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      setState(() {
        final game = ModalRoute.of(context)!.settings.arguments as Game;
        _currentRating = game.rating.toDouble();
        _selectedStatus = _statuses.where((e) => e.status == game.status).first;
        _noteTextEditingController.text = game.notes;
        for (var walkthrough in game.walkthroughs) {
          walkthroughWidgets.add(WalkthroughWidget(
            firstDate: game.releaseDate ?? DateTime.now(),
            walkthrough: walkthrough,
          ));
        }
      });
    });

    super.initState();
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
            onLongPress: () {
              setState(() {
                widget.walkthrough.startDate = null;
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
            onLongPress: () {
              setState(() {
                widget.walkthrough.endDate = null;
              });
            },
            child: Text(
              'End Date: ${widget.walkthrough.endDate != null ? formatter.format(widget.walkthrough.endDate!) : 'Tap To Set'}',
            )),
      ],
    );
  }
}
