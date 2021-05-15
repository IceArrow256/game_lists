import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_lists/pages/about_page.dart';
import 'package:game_lists/pages/add_edit_pages/game_in_list_page.dart';
import 'package:game_lists/pages/add_edit_pages/game_page.dart';
import 'package:game_lists/pages/main_page.dart';
import 'package:game_lists/pages/settings_page.dart';

class GameLists extends StatefulWidget {
  const GameLists({Key? key}) : super(key: key);

  @override
  _GameListsState createState() => _GameListsState();
}

class _GameListsState extends State<GameLists> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game Lists',
      theme: ThemeData(
          accentColor: Color(0xffbf616a),
          brightness: Brightness.dark,
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
          )),
      initialRoute: '/',
      routes: {
        // Main page
        '/': (context) => MainPage(),
        '/about': (context) => AboutPage(),
        '/settings': (context) => SettingsPage(),
        // Add Edit Page
        '/game': (context) => GamePage(),
        GameInListPage.routeName: (context) => GameInListPage(),
        // Select Pages
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
