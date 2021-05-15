import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_lists/pages/main_page/games_widget_option.dart';
import 'package:game_lists/pages/main_page/search_widget_option.dart';
import 'package:game_lists/pages/main_page/statistics_widget_option.dart';
import 'package:game_lists/pages/main_page/widget_option.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  int _selectedIndex = 1;

  List<WidgetOption>? _widgetOptions;
  TabController? _gamesTabController;
  TabController? _statisticsTabController;

  @override
  Widget build(BuildContext context) {
    _widgetOptions = <WidgetOption>[
      WidgetOption(
          title: 'Search',
          iconData: Icons.search,
          widget: SearchWidgetOption()),
      WidgetOption(
        title: 'Games',
        tabController: _gamesTabController,
        isTabScrollable: true,
        tabs: [
          Tab(text: 'Playing'),
          Tab(text: 'Planning'),
          Tab(text: 'Completed'),
          Tab(text: 'Pause'),
          Tab(text: 'Dropped'),
          Tab(text: 'All')
        ],
        iconData: Icons.games,
        widget: GamesWidgetOption(tabController: _gamesTabController),
      ),
      WidgetOption(
        title: 'Statistics',
        tabController: _statisticsTabController,
        tabs: [
          Tab(text: 'Main'),
          Tab(text: 'Top'),
        ],
        iconData: Icons.insert_chart,
        widget: StatisticsWidgetOption(tabController: _statisticsTabController),
      )
    ];
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

  @override
  void initState() {
    super.initState();
    _gamesTabController = TabController(vsync: this, length: 6);
    _statisticsTabController = TabController(vsync: this, length: 2);
  }

  void _onItemTapped(int i) {
    setState(() {
      _selectedIndex = i;
    });
  }
}
