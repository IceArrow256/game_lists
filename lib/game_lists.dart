import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_lists/database/database.dart';
import 'package:game_lists/pages/about_page.dart';
import 'package:game_lists/pages/country_page.dart';
import 'package:game_lists/pages/developer_page.dart';
import 'package:game_lists/pages/game_page.dart';
import 'package:game_lists/pages/main_page.dart';
import 'package:game_lists/pages/platform_page.dart';
import 'package:game_lists/pages/series_page.dart';
import 'package:game_lists/pages/settings_page.dart';
import 'package:game_lists/pages/tag_page.dart';

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
        '/about': (context) => AboutPage(),
        '/country': (context) => CountryPage(),
        '/developer': (context) => DeveloperPage(),
        '/game': (context) => GamePage(),
        '/platform': (context) => PlatformPage(),
        '/series': (context) => SeriesPage(),
        '/settings': (context) => SettingsPage(),
        '/tag': (context) => TagPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
