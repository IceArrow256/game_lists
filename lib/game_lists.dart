import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_lists/database/database.dart';
import 'package:game_lists/pages/about_page.dart';
import 'package:game_lists/pages/main_page.dart';
import 'package:game_lists/pages/settings_page.dart';

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
        accentColor: Colors.red,
        brightness: Brightness.dark,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MainPage(database: widget.database),
        '/settings': (context) => SettingsPage(),
        '/about': (context) => AboutPage()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
