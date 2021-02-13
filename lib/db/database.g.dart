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

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 2,
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

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  GameDao get gameDao {
    return _gameDaoInstance ??= _$GameDao(database, changeListener);
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
  Future<List<Game>> findAllGames() async {
    return _queryAdapter.queryList('SELECT * FROM Game ORDER BY name ASC',
        mapper: (Map<String, dynamic> row) => Game(row['id'] as int,
            row['name'] as String, row['cover_url'] as String));
  }

  @override
  Future<List<Game>> findGamesByName(String name) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Game WHERE name LIKE ? ORDER BY name ASC',
        arguments: <dynamic>[name],
        mapper: (Map<String, dynamic> row) => Game(row['id'] as int,
            row['name'] as String, row['cover_url'] as String));
  }

  @override
  Stream<Game> findGameById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM Game WHERE id = ?',
        arguments: <dynamic>[id],
        queryableName: 'Game',
        isView: false,
        mapper: (Map<String, dynamic> row) => Game(row['id'] as int,
            row['name'] as String, row['cover_url'] as String));
  }

  @override
  Future<void> insertGame(Game game) async {
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
