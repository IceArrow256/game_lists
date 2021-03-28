import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_lists/database/database.dart';
import 'package:game_lists/pages/main_page/games_widget_option.dart';
import 'package:game_lists/pages/main_page/home_widget_option.dart';
import 'package:game_lists/pages/main_page/search_widget_option.dart';
import 'package:game_lists/pages/main_page/statistics_widget_option.dart';
import 'package:game_lists/pages/main_page/widget_option.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key, this.database}) : super(key: key);

  final GameListsDatabase? database;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<WidgetOption> _widgetOptions = <WidgetOption>[
    WidgetOption(
      'Home',
      title: 'Game List',
      widget: HomeWidgetOption(),
      iconData: Icons.home,
    ),
    WidgetOption(
      'Search',
      title: 'Search',
      widget: SearchWidgetOption(),
      iconData: Icons.search,
    ),
    WidgetOption(
      'Games',
      title: 'Games',
      widget: GamesWidgetOption(),
      iconData: Icons.games,
    ),
    WidgetOption(
      'Statistics',
      title: 'Statistics',
      widget: StatisticsWidgetOption(),
      iconData: Icons.insert_chart,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(_widgetOptions.elementAt(_selectedIndex).title),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _widgetOptions
            .map((e) => BottomNavigationBarItem(icon: e.icon, label: e.label))
            .toList(),
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        onTap: _onItemTapped,
        elevation: 0,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Row(
                children: [
                  Text(
                    'Game Lists',
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.red,
              ),
            ),
            ListTile(
              title: Text('Settings'),
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),
            ListTile(
              title: Text('About'),
              onTap: () {
                Navigator.pushNamed(context, '/about');
              },
            ),
            ListTile(
              title: Text('Exit'),
              onTap: () {
                SystemNavigator.pop();
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex).widget,
      ),
    );
  }
}
