import 'package:flutter/material.dart';
import 'package:game_list/db/dao/game_dao.dart';
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
  GameDao _gameDao;
  GameInListDao _gameInListDao;

  @override
  Widget build(BuildContext context) {
    _gameInList = _gameInList ?? ModalRoute.of(context).settings.arguments;
    var date = _gameInList['dateAdded'] as DateTime;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async {
              await Navigator.pushNamed(context, GameInListEdit.routeName,
                  arguments: _gameInList);
              await _getGameInListForView();
              setState(() {});
            },
          ),
        ],
        title: Text(
          _gameInList['name'],
          overflow: TextOverflow.fade,
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.delete),
          onPressed: () async {
            var object =
                await _gameInListDao.findByGameId(_gameInList['gameId']);
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
                _gameInList['coverUrl'],
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
                      _gameInList['name'],
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

  _getGameInListForView() async {
    var gameInList = await _gameInListDao.findByGameId(_gameInList['gameId']);
    var game = await _gameDao.findById(_gameInList['gameId']);
    _gameInList = {
      'id': gameInList.id,
      'gameId': game.id,
      'name': game.name,
      'coverUrl': game.coverUrl,
      'dateAdded': gameInList.dateAdded,
    };
  }

  @override
  void initState() {
    _gameDao = widget.database.gameDao;
    _gameInListDao = widget.database.gameInListDao;
    super.initState();
  }
}
