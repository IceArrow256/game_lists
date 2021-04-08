// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorGameListsDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$GameListsDatabaseBuilder databaseBuilder(String name) =>
      _$GameListsDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$GameListsDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$GameListsDatabaseBuilder(null);
}

class _$GameListsDatabaseBuilder {
  _$GameListsDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$GameListsDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$GameListsDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<GameListsDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$GameListsDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$GameListsDatabase extends GameListsDatabase {
  _$GameListsDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  CountryDao? _countryDaoInstance;

  DeveloperDao? _developerDaoInstance;

  GameDao? _gameDaoInstance;

  GameDeveloperDao? _gameDeveloperDaoInstance;

  GameInListDao? _gameInListDaoInstance;

  GameInListTagDao? _gameInListTagDaoInstance;

  GamePlatformDao? _gamePlatformDaoInstance;

  GameSeriesDao? _gameSeriesDaoInstance;

  GameTagDao? _gameTagDaoInstance;

  ListTypeDao? _listTypeDaoInstance;

  PlatformDao? _platformDaoInstance;

  SeriesDao? _seriesDaoInstance;

  TagDao? _tagDaoInstance;

  WalkthroughDao? _walkthroughDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `country` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `developer` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `country_id` INTEGER, `name` TEXT, FOREIGN KEY (`country_id`) REFERENCES `country` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `game` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `name` TEXT NOT NULL, `image` BLOB, `description` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `game_developer` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `game_id` INTEGER NOT NULL, `developer_id` INTEGER NOT NULL, `is_main` INTEGER NOT NULL, FOREIGN KEY (`game_id`) REFERENCES `game` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`developer_id`) REFERENCES `developer` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `game_in_list` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `game_id` INTEGER NOT NULL, `list_type_id` INTEGER NOT NULL, `create_time` INTEGER NOT NULL, `score` INTEGER, `notes` TEXT, FOREIGN KEY (`game_id`) REFERENCES `game` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`list_type_id`) REFERENCES `list_type` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `game_in_list_tag` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `game_in_list_id` INTEGER NOT NULL, `tag_id` INTEGER NOT NULL, FOREIGN KEY (`game_in_list_id`) REFERENCES `game_in_list` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`tag_id`) REFERENCES `tag` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `game_platform` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `game_id` INTEGER NOT NULL, `platform_id` INTEGER NOT NULL, `date` INTEGER NOT NULL, FOREIGN KEY (`game_id`) REFERENCES `game` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`platform_id`) REFERENCES `platform` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `game_series` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `game_id` INTEGER NOT NULL, `series_id` INTEGER NOT NULL, FOREIGN KEY (`game_id`) REFERENCES `game` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`series_id`) REFERENCES `series` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `game_tag` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `game_id` INTEGER NOT NULL, `tag_id` INTEGER NOT NULL, FOREIGN KEY (`game_id`) REFERENCES `game` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`tag_id`) REFERENCES `tag` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `list_type` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `name` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `platform` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `name` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `series` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `name` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `tag` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `name` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `walkthrough` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `game_in_list_id` INTEGER, `start` INTEGER, `end` INTEGER, `time_played` INTEGER, FOREIGN KEY (`game_in_list_id`) REFERENCES `game_in_list` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  CountryDao get countryDao {
    return _countryDaoInstance ??= _$CountryDao(database, changeListener);
  }

  @override
  DeveloperDao get developerDao {
    return _developerDaoInstance ??= _$DeveloperDao(database, changeListener);
  }

  @override
  GameDao get gameDao {
    return _gameDaoInstance ??= _$GameDao(database, changeListener);
  }

  @override
  GameDeveloperDao get gameDeveloperDao {
    return _gameDeveloperDaoInstance ??=
        _$GameDeveloperDao(database, changeListener);
  }

  @override
  GameInListDao get gameInListDao {
    return _gameInListDaoInstance ??= _$GameInListDao(database, changeListener);
  }

  @override
  GameInListTagDao get gameInListTagDao {
    return _gameInListTagDaoInstance ??=
        _$GameInListTagDao(database, changeListener);
  }

  @override
  GamePlatformDao get gamePlatformDao {
    return _gamePlatformDaoInstance ??=
        _$GamePlatformDao(database, changeListener);
  }

  @override
  GameSeriesDao get gameSeriesDao {
    return _gameSeriesDaoInstance ??= _$GameSeriesDao(database, changeListener);
  }

  @override
  GameTagDao get gameTagDao {
    return _gameTagDaoInstance ??= _$GameTagDao(database, changeListener);
  }

  @override
  ListTypeDao get listTypeDao {
    return _listTypeDaoInstance ??= _$ListTypeDao(database, changeListener);
  }

  @override
  PlatformDao get platformDao {
    return _platformDaoInstance ??= _$PlatformDao(database, changeListener);
  }

  @override
  SeriesDao get seriesDao {
    return _seriesDaoInstance ??= _$SeriesDao(database, changeListener);
  }

  @override
  TagDao get tagDao {
    return _tagDaoInstance ??= _$TagDao(database, changeListener);
  }

  @override
  WalkthroughDao get walkthroughDao {
    return _walkthroughDaoInstance ??=
        _$WalkthroughDao(database, changeListener);
  }
}

class _$CountryDao extends CountryDao {
  _$CountryDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _countryInsertionAdapter = InsertionAdapter(
            database,
            'country',
            (Country item) =>
                <String, Object?>{'id': item.id, 'name': item.name});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Country> _countryInsertionAdapter;

  @override
  Future<List<Country>> findWithNames(String name) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Country WHERE name = ?1 ORDER BY name',
        mapper: (Map<String, Object?> row) =>
            Country(row['id'] as int?, row['name'] as String),
        arguments: [name]);
  }

  @override
  Future<List<Country>> findWithNamesLike(String name) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Country WHERE name LIKE ?1 ORDER BY name',
        mapper: (Map<String, Object?> row) =>
            Country(row['id'] as int?, row['name'] as String),
        arguments: [name]);
  }

  @override
  Future<void> insertCountry(Country country) async {
    await _countryInsertionAdapter.insert(country, OnConflictStrategy.abort);
  }
}

class _$DeveloperDao extends DeveloperDao {
  _$DeveloperDao(this.database, this.changeListener)
      : _developerInsertionAdapter = InsertionAdapter(
            database,
            'developer',
            (Developer item) => <String, Object?>{
                  'id': item.id,
                  'country_id': item.countryId,
                  'name': item.name
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final InsertionAdapter<Developer> _developerInsertionAdapter;

  @override
  Future<void> insertDeveloper(Developer developer) async {
    await _developerInsertionAdapter.insert(
        developer, OnConflictStrategy.abort);
  }
}

class _$GameDao extends GameDao {
  _$GameDao(this.database, this.changeListener)
      : _gameInsertionAdapter = InsertionAdapter(
            database,
            'game',
            (Game item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'image': item.image,
                  'description': item.description
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final InsertionAdapter<Game> _gameInsertionAdapter;

  @override
  Future<void> insertGame(Game game) async {
    await _gameInsertionAdapter.insert(game, OnConflictStrategy.abort);
  }
}

class _$GameDeveloperDao extends GameDeveloperDao {
  _$GameDeveloperDao(this.database, this.changeListener)
      : _gameDeveloperInsertionAdapter = InsertionAdapter(
            database,
            'game_developer',
            (GameDeveloper item) => <String, Object?>{
                  'id': item.id,
                  'game_id': item.gameId,
                  'developer_id': item.developerId,
                  'is_main': item.isMain ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final InsertionAdapter<GameDeveloper> _gameDeveloperInsertionAdapter;

  @override
  Future<void> insertCountry(GameDeveloper gameDeveloper) async {
    await _gameDeveloperInsertionAdapter.insert(
        gameDeveloper, OnConflictStrategy.abort);
  }
}

class _$GameInListDao extends GameInListDao {
  _$GameInListDao(this.database, this.changeListener)
      : _gameInListInsertionAdapter = InsertionAdapter(
            database,
            'game_in_list',
            (GameInList item) => <String, Object?>{
                  'id': item.id,
                  'game_id': item.gameId,
                  'list_type_id': item.listTypeId,
                  'create_time': _dateTimeConverter.encode(item.createTime),
                  'score': item.score,
                  'notes': item.notes
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final InsertionAdapter<GameInList> _gameInListInsertionAdapter;

  @override
  Future<void> insertGameInList(GameInList gameInList) async {
    await _gameInListInsertionAdapter.insert(
        gameInList, OnConflictStrategy.abort);
  }
}

class _$GameInListTagDao extends GameInListTagDao {
  _$GameInListTagDao(this.database, this.changeListener)
      : _gameInListTagInsertionAdapter = InsertionAdapter(
            database,
            'game_in_list_tag',
            (GameInListTag item) => <String, Object?>{
                  'id': item.id,
                  'game_in_list_id': item.gameInListId,
                  'tag_id': item.tagId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final InsertionAdapter<GameInListTag> _gameInListTagInsertionAdapter;

  @override
  Future<void> insertGameInListTag(GameInListTag gameInListTag) async {
    await _gameInListTagInsertionAdapter.insert(
        gameInListTag, OnConflictStrategy.abort);
  }
}

class _$GamePlatformDao extends GamePlatformDao {
  _$GamePlatformDao(this.database, this.changeListener)
      : _gamePlatformInsertionAdapter = InsertionAdapter(
            database,
            'game_platform',
            (GamePlatform item) => <String, Object?>{
                  'id': item.id,
                  'game_id': item.gameId,
                  'platform_id': item.platformId,
                  'date': _dateTimeConverter.encode(item.date)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final InsertionAdapter<GamePlatform> _gamePlatformInsertionAdapter;

  @override
  Future<void> insertGamePlatform(GamePlatform gameReleaseDate) async {
    await _gamePlatformInsertionAdapter.insert(
        gameReleaseDate, OnConflictStrategy.abort);
  }
}

class _$GameSeriesDao extends GameSeriesDao {
  _$GameSeriesDao(this.database, this.changeListener)
      : _gameSeriesInsertionAdapter = InsertionAdapter(
            database,
            'game_series',
            (GameSeries item) => <String, Object?>{
                  'id': item.id,
                  'game_id': item.gameId,
                  'series_id': item.seriesId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final InsertionAdapter<GameSeries> _gameSeriesInsertionAdapter;

  @override
  Future<void> insertGameSeries(GameSeries gameSeries) async {
    await _gameSeriesInsertionAdapter.insert(
        gameSeries, OnConflictStrategy.abort);
  }
}

class _$GameTagDao extends GameTagDao {
  _$GameTagDao(this.database, this.changeListener)
      : _gameTagInsertionAdapter = InsertionAdapter(
            database,
            'game_tag',
            (GameTag item) => <String, Object?>{
                  'id': item.id,
                  'game_id': item.gameId,
                  'tag_id': item.tagId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final InsertionAdapter<GameTag> _gameTagInsertionAdapter;

  @override
  Future<void> insertGameTag(GameTag gameTag) async {
    await _gameTagInsertionAdapter.insert(gameTag, OnConflictStrategy.abort);
  }
}

class _$ListTypeDao extends ListTypeDao {
  _$ListTypeDao(this.database, this.changeListener)
      : _listTypeInsertionAdapter = InsertionAdapter(
            database,
            'list_type',
            (ListType item) =>
                <String, Object?>{'id': item.id, 'name': item.name});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final InsertionAdapter<ListType> _listTypeInsertionAdapter;

  @override
  Future<void> insertListType(ListType listType) async {
    await _listTypeInsertionAdapter.insert(listType, OnConflictStrategy.abort);
  }
}

class _$PlatformDao extends PlatformDao {
  _$PlatformDao(this.database, this.changeListener)
      : _platformInsertionAdapter = InsertionAdapter(
            database,
            'platform',
            (Platform item) =>
                <String, Object?>{'id': item.id, 'name': item.name});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final InsertionAdapter<Platform> _platformInsertionAdapter;

  @override
  Future<void> insertPlatform(Platform platform) async {
    await _platformInsertionAdapter.insert(platform, OnConflictStrategy.abort);
  }
}

class _$SeriesDao extends SeriesDao {
  _$SeriesDao(this.database, this.changeListener)
      : _seriesInsertionAdapter = InsertionAdapter(
            database,
            'series',
            (Series item) =>
                <String, Object?>{'id': item.id, 'name': item.name});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final InsertionAdapter<Series> _seriesInsertionAdapter;

  @override
  Future<void> insertSeries(Series series) async {
    await _seriesInsertionAdapter.insert(series, OnConflictStrategy.abort);
  }
}

class _$TagDao extends TagDao {
  _$TagDao(this.database, this.changeListener)
      : _tagInsertionAdapter = InsertionAdapter(database, 'tag',
            (Tag item) => <String, Object?>{'id': item.id, 'name': item.name});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final InsertionAdapter<Tag> _tagInsertionAdapter;

  @override
  Future<void> insertTag(Tag tag) async {
    await _tagInsertionAdapter.insert(tag, OnConflictStrategy.abort);
  }
}

class _$WalkthroughDao extends WalkthroughDao {
  _$WalkthroughDao(this.database, this.changeListener)
      : _walkthroughInsertionAdapter = InsertionAdapter(
            database,
            'walkthrough',
            (Walkthrough item) => <String, Object?>{
                  'id': item.id,
                  'game_in_list_id': item.gameInListId,
                  'start': _dateTimeConverterNullable.encode(item.start),
                  'end': _dateTimeConverterNullable.encode(item.end),
                  'time_played': item.timePlayed
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final InsertionAdapter<Walkthrough> _walkthroughInsertionAdapter;

  @override
  Future<void> insertWalkthrough(Walkthrough walkthrough) async {
    await _walkthroughInsertionAdapter.insert(
        walkthrough, OnConflictStrategy.abort);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
final _dateTimeConverterNullable = DateTimeConverterNullable();
