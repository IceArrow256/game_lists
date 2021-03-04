import 'package:flutter/material.dart';
import 'package:game_list/db/dao/game_dao.dart';
import 'package:game_list/db/dao/game_in_list_dao.dart';
import 'package:game_list/db/database.dart';
import 'package:game_list/db/model/game.dart';
import 'package:game_list/db/model/game_in_list.dart';
import 'package:game_list/pages/game/game_edit.dart';

class GameView extends StatefulWidget {
  static const routeName = '/gameView';
  final AppDatabase database;

  const GameView({Key key, @required this.database}) : super(key: key);

  @override
  _GameViewState createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  Game _game;
  GameDao _gameDao;
  GameInListDao _gameInListDao;

  @override
  Widget build(BuildContext context) {
    _game = _game ?? ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async {
              await Navigator.pushNamed(context, GameEdit.routeName,
                  arguments: _game);
              _game = _game = await _gameDao.findById(_game.id);
              setState(() {});
            },
          ),
        ],
        title: Text(
          _game.name,
          overflow: TextOverflow.fade,
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: FutureBuilder<GameInList>(
            future: _gameInListDao.findByGameId(_game.id),
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                return Icon(Icons.delete);
              } else {
                return Icon(Icons.add);
              }
            },
          ),
          onPressed: () async {
            var gameInList = await _gameInListDao.findByGameId(_game.id);
            if (gameInList == null) {
              var now = DateTime.now();
              var gameInList = GameInList(null, _game.id, now, Status.inbox);
              await _gameInListDao.insertObject(gameInList);
              setState(() {});
            } else {
              await _gameInListDao.deleteObject(gameInList);
              setState(() {});
            }
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
                _game.coverUrl,
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
                      _game.name,
                      style: TextStyle(fontSize: 20),
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
    _gameDao = widget.database.gameDao;
    _gameInListDao = widget.database.gameInListDao;
    super.initState();
  }
}
