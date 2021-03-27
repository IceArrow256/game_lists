import 'package:flutter/material.dart';
import 'package:game_lists/database/database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await $FloorGameListsDatabase
      .databaseBuilder('game_lists_database.db')
      .build();
  runApp(GameLists(database: database));
}

class GameLists extends StatefulWidget {
  const GameLists({Key? key, this.database}) : super(key: key);

  final GameListsDatabase? database;

  @override
  _GameListsState createState() => _GameListsState();
}

class _GameListsState extends State<GameLists> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game Lists',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HomePage(title: 'Game Lists'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Center(),
    );
  }
}
