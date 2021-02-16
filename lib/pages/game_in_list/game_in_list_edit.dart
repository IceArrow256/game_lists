import 'package:flutter/material.dart';
import 'package:game_list/db/dao/game_in_list_dao.dart';
import 'package:game_list/db/database.dart';

class GameInListEdit extends StatefulWidget {
  static const routeName = '/gameInViewEdit';
  final AppDatabase database;

  const GameInListEdit({Key key, @required this.database}) : super(key: key);

  @override
  _GameInListEditState createState() => _GameInListEditState();
}

class _GameInListEditState extends State<GameInListEdit> {
  final _formKey = GlobalKey<FormState>();
  Map<String, Object> _gameInList;
  GameInListDao _gameInListDao;

  @override
  Widget build(BuildContext context) {
    _gameInList = ModalRoute.of(context).settings.arguments;
    var date = _gameInList['dateAdded'] as DateTime;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              _deleteGameInList();
              Navigator.pop(context, 'delete');
            },
          ),
        ],
        title: Text('Edit Game In List'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();

            _updateGameInList();
            Navigator.pop(context, _gameInList);
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
                    initialValue: _gameInList['name'],
                    decoration: InputDecoration(labelText: 'Name'),
                    enabled: false,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    onSaved: (value) {},
                  ),
                  TextFormField(
                    initialValue: _gameInList['coverUrl'],
                    decoration: InputDecoration(labelText: 'Cover URL'),
                    enabled: false,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    initialValue:
                        '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}',
                    decoration: InputDecoration(labelText: 'Date Added'),
                    enabled: false,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  )
                ],
              ))),
    );
  }

  @override
  void initState() {
    _gameInListDao = widget.database.gameInListDao;
    super.initState();
  }

  void _deleteGameInList() async {
    var object = await _gameInListDao.findByGameId(_gameInList['gameId']);
    await _gameInListDao.deleteObject(object);
  }

  void _updateGameInList() async {
    var object = await _gameInListDao.findByGameId(_gameInList['gameId']);
    await _gameInListDao.updateObject(object);
  }
}
