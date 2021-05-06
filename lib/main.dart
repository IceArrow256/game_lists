import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_lists/game_lists.dart';
import 'package:game_lists/model/developer.dart';
import 'package:game_lists/model/franchise.dart';
import 'package:game_lists/model/game.dart';
import 'package:game_lists/model/genre.dart';
import 'package:game_lists/model/platform.dart';
import 'package:game_lists/model/status.dart';
import 'package:game_lists/model/walkthrough.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(DeveloperAdapter());
  Hive.registerAdapter(FranchiseAdapter());
  Hive.registerAdapter(GameAdapter());
  Hive.registerAdapter(GenreAdapter());
  Hive.registerAdapter(PlatformAdapter());
  Hive.registerAdapter(StatusAdapter());
  Hive.registerAdapter(WalkthroughAdapter());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Color(0xFF303030),
    statusBarColor: Colors.grey.shade900,
  ));

  WidgetsFlutterBinding.ensureInitialized();
  runApp(GameLists());
}
