import 'package:flutter/material.dart';
import 'package:game_list/db/database.dart';
import 'package:game_list/db/model/game.dart';

class GameAdd extends StatefulWidget {
  static const routeName = '/gameAdd';

  @override
  _GameAddState createState() => _GameAddState();
}

class _GameAddState extends State<GameAdd> {
  final _formKey = GlobalKey<FormState>();
  String _name;
  String _coverUrl;

  final Future<AppDatabase> _database = $FloorAppDatabase
      .databaseBuilder('game_list.db')
      .addMigrations([migration1to2]).build();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add game'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            _createGame();
            Navigator.pop(context);
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

  void _createGame() async {
    final database = await _database;
    var game = Game(null, _name, _coverUrl);
    database.gameDao.insertObject(game);
  }
}
