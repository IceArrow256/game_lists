import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_list/themes/nord.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Nord.nord1,
  accentColor: Nord.nord11,
  fontFamily: 'Inter',
  scaffoldBackgroundColor: Nord.nord1,
  cardColor: Nord.nord3,
  toggleableActiveColor: Nord.nord11,
  appBarTheme: AppBarTheme(
      brightness: Brightness.dark,
      color: Nord.nord1,
      shadowColor: Colors.transparent,
      textTheme: TextTheme(
        headline6: TextStyle(color: Nord.nord6, fontSize: 22),
      ),
      iconTheme: IconThemeData(color: Nord.nord6)),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Nord.nord0,
      selectedItemColor: Nord.nord11,
      unselectedItemColor: Nord.nord6),
);

SystemUiOverlayStyle darkSystemUiOverlayStyle = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Nord.nord0,
    systemNavigationBarIconBrightness: Brightness.light);
