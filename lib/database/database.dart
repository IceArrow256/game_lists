import 'dart:async';

import 'package:floor/floor.dart';
import 'package:game_lists/database/dao/country_dao.dart';
import 'package:game_lists/database/dao/developer_dao.dart';
import 'package:game_lists/database/dao/game_dao.dart';
import 'package:game_lists/database/dao/game_developer_dao.dart';
import 'package:game_lists/database/dao/game_in_list_dao.dart';
import 'package:game_lists/database/dao/game_in_list_tag_dao.dart';
import 'package:game_lists/database/dao/game_release_date_dao.dart';
import 'package:game_lists/database/dao/game_series_dao.dart';
import 'package:game_lists/database/dao/game_tag_dao.dart';
import 'package:game_lists/database/dao/list_type_dao.dart';
import 'package:game_lists/database/dao/platform_dao.dart';
import 'package:game_lists/database/dao/series_dao.dart';
import 'package:game_lists/database/dao/tag_dao.dart';
import 'package:game_lists/database/dao/walkthrough_dao.dart';
import 'package:game_lists/database/date_time_converter.dart';
import 'package:game_lists/database/entities/country.dart';
import 'package:game_lists/database/entities/developer.dart';
import 'package:game_lists/database/entities/game.dart';
import 'package:game_lists/database/entities/game_developer.dart';
import 'package:game_lists/database/entities/game_in_list.dart';
import 'package:game_lists/database/entities/game_in_list_tag.dart';
import 'package:game_lists/database/entities/game_release_date.dart';
import 'package:game_lists/database/entities/game_series.dart';
import 'package:game_lists/database/entities/game_tag.dart';
import 'package:game_lists/database/entities/list_type.dart';
import 'package:game_lists/database/entities/platform.dart';
import 'package:game_lists/database/entities/series.dart';
import 'package:game_lists/database/entities/tag.dart';
import 'package:game_lists/database/entities/walkthrough.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@TypeConverters([DateTimeConverter])
@Database(version: 1, entities: [
  Country,
  Developer,
  Game,
  GameDeveloper,
  GameInList,
  GameInListTag,
  GameReleaseDate,
  GameSeries,
  GameTag,
  ListType,
  Platform,
  Series,
  Tag,
  Walkthrough
])
abstract class GameListsDatabase extends FloorDatabase {
  CountryDao get countryDao;

  DeveloperDao get developerDao;

  GameDao get gameDao;

  GameDeveloperDao get gameDeveloperDao;

  GameInListDao get gameInListDao;

  GameInListTagDao get gameInListTagDao;

  GameReleaseDateDao get gameReleaseDateDao;

  GameSeriesDao get gameSeriesDao;

  GameTagDao get gameTagDao;

  ListTypeDao get listTypeDao;

  PlatformDao get platformDao;

  SeriesDao get seriesDao;

  TagDao get tagDao;

  WalkthroughDao get walkthroughDao;
}
