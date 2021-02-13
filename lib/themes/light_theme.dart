import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_list/themes/nord.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Nord.nord11,
  accentColor: Nord.nord11,
  fontFamily: 'Inter',
  scaffoldBackgroundColor: Nord.nord5,
  cardColor: Nord.nord6,
  toggleableActiveColor: Nord.nord11,
  appBarTheme: AppBarTheme(
      brightness: Brightness.light,
      color: Nord.nord5,
      shadowColor: Colors.transparent,
      textTheme: TextTheme(
        headline6: TextStyle(color: Nord.nord0, fontSize: 22),
      ),
      iconTheme: IconThemeData(color: Nord.nord0)),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Nord.nord4,
      selectedItemColor: Nord.nord11,
      unselectedItemColor: Nord.nord0),
);

SystemUiOverlayStyle lightSystemUiOverlayStyle = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Nord.nord4,
    systemNavigationBarIconBrightness: Brightness.dark);
