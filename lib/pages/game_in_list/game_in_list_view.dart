import 'package:flutter/material.dart';
import 'package:game_list/db/dao/game_in_list_dao.dart';
import 'package:game_list/db/database.dart';
import 'package:game_list/pages/game_in_list/game_in_list_edit.dart';

class GameInListView extends StatefulWidget {
  static const routeName = '/gameInListView';
  final AppDatabase database;

  const GameInListView({Key key, @required this.database}) : super(key: key);

  @override
  _GameInListViewState createState() => _GameInListViewState();
}

class _GameInListViewState extends State<GameInListView> {
  Map<String, Object> _gameInList;
  GameInListDao _gameInListDao;

  @override
  Widget build(BuildContext context) {
    final Map<String, Object> gameInList =
        _gameInList ?? ModalRoute.of(context).settings.arguments;
    var date = gameInList['dateAdded'] as DateTime;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async {
              var _result = (await Navigator.pushNamed(
                  context, GameInListEdit.routeName,
                  arguments: gameInList));
              if (_result.runtimeType == Map) {
                setState(() {
                  _gameInList = _result as Map<String, Object>;
                });
              } else if (_result.runtimeType == String) {
                if (_result == 'delete') {
                  Navigator.pop(context);
                }
              }
            },
          ),
        ],
        title: Text(
          gameInList['name'],
          overflow: TextOverflow.fade,
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.delete),
          onPressed: () async {
            var object =
                await _gameInListDao.findByGameId(gameInList['gameId']);
            await _gameInListDao.deleteObject(object);
            setState(() {});
            Navigator.pop(context);
          }),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(2.0),
              child: Image.network(
                gameInList['coverUrl'],
                width: 128,
                height: 171,
                fit: BoxFit.fill,
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      gameInList['name'],
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      'Date added: ${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}',
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    _gameInListDao = widget.database.gameInListDao;
    super.initState();
  }
}
