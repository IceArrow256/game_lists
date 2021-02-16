import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_list/db/database.dart';
import 'package:game_list/pages/game/game_add.dart';
import 'package:game_list/pages/game/game_edit.dart';
import 'package:game_list/pages/game/game_view.dart';
import 'package:game_list/pages/game_in_list/game_in_list_edit.dart';
import 'package:game_list/pages/game_in_list/game_in_list_view.dart';
import 'package:game_list/pages/home.dart';
import 'package:game_list/themes/dark_theme.dart';
import 'package:game_list/themes/light_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await $FloorAppDatabase
      .databaseBuilder('game_list.db')
      .addMigrations([migration1to2, migration2to3]).build();
  runApp(App(database: database));
}

class App extends StatefulWidget {
  final AppDatabase database;

  const App({Key key, @required this.database}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  bool _isDarkTheme;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game List',
      theme: _isDarkTheme ? darkTheme : lightTheme,
      debugShowCheckedModeBanner: false,
      routes: {
        Home.routeName: (context) => Home(
            database: widget.database,
            isDarkTheme: _isDarkTheme,
            updateTheme: _updateTheme),
        GameAdd.routeName: (context) => GameAdd(database: widget.database),
        GameEdit.routeName: (context) => GameEdit(database: widget.database),
        GameInListEdit.routeName: (context) =>
            GameInListEdit(database: widget.database),
        GameInListView.routeName: (context) =>
            GameInListView(database: widget.database),
        GameView.routeName: (context) => GameView(database: widget.database),
      },
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _updateAppBar();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    _isDarkTheme = false;
    _loadTheme();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  _loadTheme() async {
    var prefs = await SharedPreferences.getInstance();
    var isDarkTheme = prefs.getBool('isDarkTheme') ?? _isDarkTheme;
    setState(() {
      _isDarkTheme = isDarkTheme;
    });
    _updateAppBar();
  }

  _updateAppBar() {
    var systemOverlayStyle =
        _isDarkTheme ? darkSystemUiOverlayStyle : lightSystemUiOverlayStyle;
    SystemChrome.setSystemUIOverlayStyle(systemOverlayStyle);
  }

  _updateTheme(bool value) async {
    setState(() {
      _isDarkTheme = value;
    });
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkTheme', _isDarkTheme);
    _updateAppBar();
  }
}
