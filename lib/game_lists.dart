import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_lists/pages/about_page.dart';
import 'package:game_lists/pages/add_edit_pages/country_page.dart';
import 'package:game_lists/pages/add_edit_pages/company_page.dart';
import 'package:game_lists/pages/select_pages/select_company_page.dart';
import 'package:game_lists/pages/add_edit_pages/game_page.dart';
import 'package:game_lists/pages/main_page.dart';
import 'package:game_lists/pages/add_edit_pages/platform_page.dart';
import 'package:game_lists/pages/add_edit_pages/series_page.dart';
import 'package:game_lists/pages/select_pages/select_platform_page.dart';
import 'package:game_lists/pages/select_pages/select_series_page.dart';
import 'package:game_lists/pages/select_pages/select_tag_page.dart';
import 'package:game_lists/pages/settings_page.dart';
import 'package:game_lists/pages/add_edit_pages/tag_page.dart';

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
        accentColor: Colors.red,
        brightness: Brightness.dark,
      ),
      initialRoute: '/',
      routes: {
        // Main page
        '/': (context) => MainPage(),
        '/about': (context) => AboutPage(),
        '/settings': (context) => SettingsPage(),
        // Add Edit Page
        '/country': (context) => CountryPage(),
        CompanyPage.routeName: (context) => CompanyPage(),
        '/game': (context) => GamePage(),
        '/platform': (context) => PlatformPage(),
        '/series': (context) => SeriesPage(),
        '/tag': (context) => TagPage(),
        // Select Pages
        SelectCompanyPage.routeName: (context) => SelectCompanyPage(),
        '/select_platform': (context) => SelectPlatformPage(),
        '/select_series': (context) => SelectSeriesPage(),
        '/select_tag': (context) => SelectTagPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
