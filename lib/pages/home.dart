import 'package:flutter/material.dart';
import 'package:game_list/db/database.dart';
import 'package:game_list/pages/game/game_add.dart';
import 'package:game_list/pages/tabs/tabs.dart';

class Home extends StatefulWidget {
  static const routeName = '/';
  final ValueChanged<bool> updateTheme;
  final bool isDarkTheme;
  final AppDatabase database;

  const Home(
      {Key key,
      @required this.database,
      @required this.isDarkTheme,
      @required this.updateTheme})
      : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class Tab {
  final String title;
  final String label;
  final Widget widget;
  final Icon icon;

  Tab(
      {@required this.title,
      @required this.label,
      @required this.widget,
      @required IconData iconData})
      : icon = Icon(iconData) {
    assert(title != null, 'Tab must have name');
    assert(label != null, 'Tab must have widget');
    assert(widget != null, 'Tab must have widget');
    assert(iconData != null, 'Tab must have widget');
  }
}

class _HomeState extends State<Home> {
  int _currentIndex;
  bool _isSearching;
  String _search;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      Tab(
          title: 'Game List',
          label: 'Home',
          widget: HomeTab(),
          iconData: Icons.home_outlined),
      Tab(
          title: 'Search',
          label: 'Search',
          widget: SearchTab(database: widget.database, search: _search),
          iconData: Icons.search_outlined),
      Tab(
          title: 'Games',
          label: 'Games',
          widget: GamesTab(database: widget.database, search: _search),
          iconData: Icons.games),
      Tab(
          title: 'Settings',
          label: 'Settings',
          widget: SettingsTab(
              isDarkTheme: widget.isDarkTheme,
              updateIsDarkTheme: widget.updateTheme),
          iconData: Icons.settings),
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
            : Text(tabs[_currentIndex].title),
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
      body: tabs[_currentIndex].widget,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        iconSize: 32,
        items: tabs
            .map((e) => BottomNavigationBarItem(icon: e.icon, label: e.label))
            .toList(),
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
