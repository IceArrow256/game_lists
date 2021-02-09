import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_list/themes/nord.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Nord.nord5,
  accentColor: Nord.nord11,
  fontFamily: 'Inter',
  scaffoldBackgroundColor: Nord.nord5,
  cardColor: Nord.nord6,
  toggleableActiveColor: Nord.nord11,
  appBarTheme: AppBarTheme(
    shadowColor: Colors.transparent,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Nord.nord4,
        systemNavigationBarIconBrightness: Brightness.dark),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Nord.nord4,
      selectedItemColor: Nord.nord11,
      unselectedItemColor: Nord.nord0),
);
