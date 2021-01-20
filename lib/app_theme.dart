import 'package:flutter/material.dart';
import 'nord.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: Nord.nord6,
      appBarTheme: AppBarTheme(color: Nord.nord0),
      primaryTextTheme: TextTheme(headline6: TextStyle(color: Nord.nord6)),
      textTheme: TextTheme(bodyText2: TextStyle(color: Nord.nord6)),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Nord.nord4,
          selectedItemColor: Nord.nord11,
          unselectedItemColor: Nord.nord0));
}
