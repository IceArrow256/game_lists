import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_lists/database/database.dart';
import 'package:game_lists/pages/main_page/games_widget_option.dart';
import 'package:game_lists/pages/main_page/search_widget_option.dart';
import 'package:game_lists/pages/main_page/statistics_widget_option.dart';
import 'package:game_lists/pages/main_page/widget_option.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key, this.database}) : super(key: key);

  final GameListsDatabase? database;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  int _selectedIndex = 1;

  List<WidgetOption>? _widgetOptions;

  @override
  void initState() {
    super.initState();
    var gamesTabController = TabController(vsync: this, length: 5);
    var statisticsTabController = TabController(vsync: this, length: 2);
    _widgetOptions = <WidgetOption>[
      WidgetOption(
          title: 'Search',
          iconData: Icons.search,
          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () async {
                Navigator.pushNamed(context, '/game');
              }),
          widget: SearchWidgetOption()),
      WidgetOption(
          title: 'Games',
          tabController: gamesTabController,
          isTabScrollable: true,
          tabs: [
            Tab(text: 'Playing'),
            Tab(text: 'Planning'),
            Tab(text: 'Completed'),
            Tab(text: 'Pause'),
            Tab(text: 'Dropped')
          ],
          iconData: Icons.games,
          widget: GamesWidgetOption(tabController: gamesTabController)),
      WidgetOption(
        title: 'Statistics',
        tabController: statisticsTabController,
        tabs: [
          Tab(text: 'Player'),
          Tab(text: 'Global'),
        ],
        iconData: Icons.insert_chart,
        widget: StatisticsWidgetOption(tabController: statisticsTabController),
      )
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          _widgetOptions!.elementAt(_selectedIndex).floatingActionButton,
      appBar: _widgetOptions!.elementAt(_selectedIndex).appBar,
      bottomNavigationBar: BottomNavigationBar(
        items: _widgetOptions!.map((e) => e.bottomNavigationBarItem).toList(),
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
        child: _widgetOptions!.elementAt(_selectedIndex).widget,
      ),
    );
  }
}
