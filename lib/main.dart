import 'package:flutter/material.dart';
import 'package:game_list/pages/game/game_edit.dart';
import 'package:game_list/pages/game/game_view.dart';
import 'package:game_list/pages/game/game_add.dart';
import 'package:game_list/pages/home.dart';
import 'package:game_list/themes/dark_theme.dart';
import 'package:game_list/themes/light_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  bool _isDarkTheme;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game List',
      theme: _isDarkTheme ? darkTheme : lightTheme,
      debugShowCheckedModeBanner: false,
      routes: {
        Home.routeName: (context) =>
            Home(isDarkTheme: _isDarkTheme, updateTheme: _updateTheme),
        GameView.routeName: (context) => GameView(),
        GameAdd.routeName: (context) => GameAdd(),
        GameEdit.routeName: (context) => GameEdit(),
      },
    );
  }

  @override
  void initState() {
    _isDarkTheme = false;
    _applyTheme();
    super.initState();
  }

  _applyTheme() async {
    var prefs = await SharedPreferences.getInstance();
    var isDarkTheme = prefs.getBool('isDarkTheme') ?? _isDarkTheme;
    setState(() {
      _isDarkTheme = isDarkTheme;
    });
  }

  _updateTheme(bool value) async {
    setState(() {
      _isDarkTheme = value;
    });
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkTheme', _isDarkTheme);
  }
}
