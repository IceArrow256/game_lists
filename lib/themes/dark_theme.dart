import 'package:flutter/material.dart';

import 'package:game_list/themes/nord.dart';

ThemeData darkTheme = ThemeData(
  fontFamily: 'Inter',
  accentColor: Nord.nord11,
  appBarTheme: AppBarTheme(
    color: Nord.nord0,
    brightness: Brightness.dark,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Nord.nord0,
      selectedItemColor: Nord.nord11,
      unselectedItemColor: Nord.nord6),
  brightness: Brightness.dark,
  cardColor: Nord.nord2,
  primaryTextTheme: TextTheme(
      headline6: TextStyle(
    color: Nord.nord6,
  )),
  scaffoldBackgroundColor: Nord.nord1,
  textTheme: TextTheme(
    bodyText2: TextStyle(
      color: Nord.nord6,
    ),
  ),
  toggleableActiveColor: Nord.nord11,
);
