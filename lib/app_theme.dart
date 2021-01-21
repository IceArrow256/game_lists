import 'package:flutter/material.dart';
import 'nord.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
      appBarTheme: AppBarTheme(color: Nord.nord0),
      primaryTextTheme: TextTheme(
          headline6: TextStyle(
        color: Nord.nord6,
        fontFamily: 'Inter',
      )),
      scaffoldBackgroundColor: Nord.nord6,
      textTheme: TextTheme(
          bodyText2: TextStyle(
        color: Nord.nord0,
        fontFamily: 'Inter',
      )),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Nord.nord4,
          selectedItemColor: Nord.nord11,
          unselectedItemColor: Nord.nord0));
  static final ThemeData darkTheme = ThemeData(
      appBarTheme: AppBarTheme(color: Nord.nord0),
      primaryTextTheme: TextTheme(
          headline6: TextStyle(
        color: Nord.nord6,
        fontFamily: 'Inter',
      )),
      scaffoldBackgroundColor: Nord.nord3,
      textTheme: TextTheme(
          bodyText2: TextStyle(
        color: Nord.nord6,
        fontFamily: 'Inter',
      )),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Nord.nord0,
          selectedItemColor: Nord.nord11,
          unselectedItemColor: Nord.nord6));
}
