import 'package:flutter/material.dart';
import 'package:game_list/db/database.dart';
import 'package:game_list/db/model/game.dart';

class GameEdit extends StatefulWidget {
  static const routeName = '/gameEdit';
  final AppDatabase database;

  const GameEdit({Key key, @required this.database}) : super(key: key);

  @override
  _GameEditState createState() => _GameEditState();
}

class _GameEditState extends State<GameEdit> {
  final _formKey = GlobalKey<FormState>();
  Game _game;
  String _name;
  String _coverUrl;

  @override
  Widget build(BuildContext context) {
    _game = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              _deleteGame(_game);
              Navigator.pop(context, 'delete');
            },
          ),
        ],
        title: Text('Edit game'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            var game = Game(_game.id, _name, _coverUrl);
            _updateGame(game);
            Navigator.pop(context, game);
          }
        },
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    initialValue: _game.name,
                    decoration: InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _name = value;
                    },
                  ),
                  TextFormField(
                    initialValue: _game.coverUrl,
                    decoration: InputDecoration(labelText: 'Cover URL'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _coverUrl = value;
                    },
                  )
                ],
              ))),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  void _deleteGame(Game game) async {
    await widget.database.gameDao.deleteGame(game);
  }

  void _updateGame(Game game) async {
    await widget.database.gameDao.updateGame(game);
  }
}
