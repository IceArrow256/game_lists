import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_lists/database/database.dart';
import 'package:game_lists/game_lists.dart';
import 'package:provider/provider.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Color(0xFF303030),
    statusBarColor: Colors.grey.shade900,
  ));

  WidgetsFlutterBinding.ensureInitialized();
  final database = await $FloorGameListsDatabase
      .databaseBuilder('game_lists_database.db')
      .build();
  runApp(Provider<GameListsDatabase>(
    create: (_) => database,
    child: GameLists(database: database),
  ));
}
