// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  GameDao _gameDaoInstance;

  GameInListDao _gameInListDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 3,
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
            'CREATE TABLE IF NOT EXISTS `Game` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `cover_url` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `GameInList` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `game_id` INTEGER NOT NULL, `date_added` INTEGER NOT NULL, FOREIGN KEY (`game_id`) REFERENCES `Game` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE UNIQUE INDEX `index_GameInList_game_id` ON `GameInList` (`game_id`)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  GameDao get gameDao {
    return _gameDaoInstance ??= _$GameDao(database, changeListener);
  }

  @override
  GameInListDao get gameInListDao {
    return _gameInListDaoInstance ??= _$GameInListDao(database, changeListener);
  }
}

class _$GameDao extends GameDao {
  _$GameDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _gameInsertionAdapter = InsertionAdapter(
            database,
            'Game',
            (Game item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'cover_url': item.coverUrl
                },
            changeListener),
        _gameUpdateAdapter = UpdateAdapter(
            database,
            'Game',
            ['id'],
            (Game item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'cover_url': item.coverUrl
                },
            changeListener),
        _gameDeletionAdapter = DeletionAdapter(
            database,
            'Game',
            ['id'],
            (Game item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'cover_url': item.coverUrl
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Game> _gameInsertionAdapter;

  final UpdateAdapter<Game> _gameUpdateAdapter;

  final DeletionAdapter<Game> _gameDeletionAdapter;

  @override
  Stream<List<Game>> findAllAsStream() {
    return _queryAdapter.queryListStream('SELECT * FROM Game ORDER BY name ASC',
        queryableName: 'Game',
        isView: false,
        mapper: (Map<String, dynamic> row) => Game(row['id'] as int,
            row['name'] as String, row['cover_url'] as String));
  }

  @override
  Stream<List<Game>> findAllAsStreamByName(String name) {
    return _queryAdapter.queryListStream(
        'SELECT * FROM Game WHERE name LIKE ? ORDER BY name ASC',
        arguments: <dynamic>[name],
        queryableName: 'Game',
        isView: false,
        mapper: (Map<String, dynamic> row) => Game(row['id'] as int,
            row['name'] as String, row['cover_url'] as String));
  }

  @override
  Future<List<Game>> findAllGames() async {
    return _queryAdapter.queryList('SELECT * FROM Game ORDER BY name ASC',
        mapper: (Map<String, dynamic> row) => Game(row['id'] as int,
            row['name'] as String, row['cover_url'] as String));
  }

  @override
  Future<Game> findById(int id) async {
    return _queryAdapter.query('SELECT * FROM Game WHERE id = ?',
        arguments: <dynamic>[id],
        mapper: (Map<String, dynamic> row) => Game(row['id'] as int,
            row['name'] as String, row['cover_url'] as String));
  }

  @override
  Future<void> insertObject(Game game) async {
    await _gameInsertionAdapter.insert(game, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateGame(Game game) async {
    await _gameUpdateAdapter.update(game, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteGame(Game game) async {
    await _gameDeletionAdapter.delete(game);
  }

  @override
  Future<int> deleteGames(List<Game> games) {
    return _gameDeletionAdapter.deleteListAndReturnChangedRows(games);
  }
}

class _$GameInListDao extends GameInListDao {
  _$GameInListDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _gameInListInsertionAdapter = InsertionAdapter(
            database,
            'GameInList',
            (GameInList item) => <String, dynamic>{
                  'id': item.id,
                  'game_id': item.gameId,
                  'date_added': _dateTimeConverter.encode(item.dateAdded)
                }),
        _gameInListUpdateAdapter = UpdateAdapter(
            database,
            'GameInList',
            ['id'],
            (GameInList item) => <String, dynamic>{
                  'id': item.id,
                  'game_id': item.gameId,
                  'date_added': _dateTimeConverter.encode(item.dateAdded)
                }),
        _gameInListDeletionAdapter = DeletionAdapter(
            database,
            'GameInList',
            ['id'],
            (GameInList item) => <String, dynamic>{
                  'id': item.id,
                  'game_id': item.gameId,
                  'date_added': _dateTimeConverter.encode(item.dateAdded)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<GameInList> _gameInListInsertionAdapter;

  final UpdateAdapter<GameInList> _gameInListUpdateAdapter;

  final DeletionAdapter<GameInList> _gameInListDeletionAdapter;

  @override
  Future<List<GameInList>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM GameInList',
        mapper: (Map<String, dynamic> row) => GameInList(
            row['id'] as int,
            row['game_id'] as int,
            _dateTimeConverter.decode(row['date_added'] as int)));
  }

  @override
  Future<GameInList> findByGameId(int id) async {
    return _queryAdapter.query('SELECT * FROM GameInList WHERE game_id = ?',
        arguments: <dynamic>[id],
        mapper: (Map<String, dynamic> row) => GameInList(
            row['id'] as int,
            row['game_id'] as int,
            _dateTimeConverter.decode(row['date_added'] as int)));
  }

  @override
  Future<void> insertObject(GameInList gameInList) async {
    await _gameInListInsertionAdapter.insert(
        gameInList, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateGameInList(GameInList gameInList) async {
    await _gameInListUpdateAdapter.update(
        gameInList, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteObject(GameInList gameInList) async {
    await _gameInListDeletionAdapter.delete(gameInList);
  }

  @override
  Future<int> deleteGamesInList(List<GameInList> gamesInList) {
    return _gameInListDeletionAdapter
        .deleteListAndReturnChangedRows(gamesInList);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
