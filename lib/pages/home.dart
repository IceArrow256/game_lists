import 'package:flutter/material.dart';
import 'package:game_list/db/database.dart';
import 'package:game_list/pages/game/game_add.dart';
import 'package:game_list/pages/tabs/tabs.dart';

class Home extends StatefulWidget {
  static const routeName = '/';

  final ValueChanged<bool> updateTheme;
  final bool isDarkTheme;

  @override
  const Home({Key key, @required this.isDarkTheme, @required this.updateTheme})
      : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex;
  bool _isSearching;
  String _search;
  final Future<AppDatabase> _database = $FloorAppDatabase
      .databaseBuilder('game_list.db')
      .addMigrations([migration1to2]).build();

  final tabsTitle = [
    'Game List',
    'Search',
    'Games',
    'Settings',
  ];

  @override
  Widget build(BuildContext context) {
    final tabs = [
      HomeTab(),
      SearchTab(database: _database, search: _search),
      GamesTab(database: _database, search: _search),
      SettingsTab(
          isDarkTheme: widget.isDarkTheme,
          updateIsDarkTheme: widget.updateTheme) // Settings tab
    ];
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.gamepad),
        title: (_isSearching && _currentIndex == 1)
            ? TextField(
                autofocus: true,
                onChanged: (value) {
                  setState(() {
                    _search = value;
                  });
                },
                decoration: InputDecoration(
                    hintText: 'Search', icon: Icon(Icons.search)),
              )
            : Text(tabsTitle[_currentIndex]),
        actions: [
          Visibility(
              visible: _currentIndex == 1,
              child: IconButton(
                  icon: Icon(!_isSearching ? Icons.search : Icons.clear),
                  onPressed: () {
                    setState(() {
                      _isSearching = !_isSearching;
                      if (!_isSearching) {
                        _search = '';
                      }
                    });
                  }))
        ],
      ),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        iconSize: 32,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.games), label: 'Games'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedFontSize: 12,
        type: BottomNavigationBarType.fixed,
        unselectedFontSize: 12,
      ),
      floatingActionButton: Visibility(
        visible: _currentIndex == 1,
        child: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            await Navigator.pushNamed(context, GameAdd.routeName);
            setState(() {});
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    _currentIndex = 0;
    _isSearching = false;
    _search = '';
    super.initState();
  }
}
