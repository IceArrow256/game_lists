import 'package:flutter/material.dart';

import 'package:game_list/themes/nord.dart';

ThemeData lightTheme = ThemeData(
  fontFamily: 'Inter',
  accentColor: Nord.nord11,
  appBarTheme: AppBarTheme(
    color: Nord.nord0,
    brightness: Brightness.dark,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Nord.nord4,
      selectedItemColor: Nord.nord11,
      unselectedItemColor: Nord.nord0),
  brightness: Brightness.light,
  cardColor: Nord.nord6,
  primaryTextTheme: TextTheme(
      headline6: TextStyle(
    color: Nord.nord6,
  )),
  scaffoldBackgroundColor: Nord.nord5,
  textTheme: TextTheme(
    bodyText2: TextStyle(
      color: Nord.nord0,
    ),
  ),
  toggleableActiveColor: Nord.nord11,
);
