import 'package:flutter/material.dart';
import 'package:game_list/db/model/game.dart';
import 'package:game_list/pages/game/game_edit.dart';

class GameView extends StatefulWidget {
  static const routeName = '/gameView';

  @override
  _GameViewState createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  Game _game;

  @override
  Widget build(BuildContext context) {
    final Game game = _game ?? ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              var _result = (await Navigator.pushNamed(
                  context, GameEdit.routeName,
                  arguments: game));
              if (_result.runtimeType == Game) {
                setState(() {
                  _game = _result as Game;
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
          game.name,
          overflow: TextOverflow.fade,
        ),
      ),
      floatingActionButton:
          FloatingActionButton(child: Icon(Icons.add), onPressed: () {}),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                game.coverUrl,
                width: 128,
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                child: Column(
                  children: [
                    Text(
                      game.name,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
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
}
