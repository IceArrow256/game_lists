import 'package:floor/floor.dart';
import 'package:game_lists/database/entities/developer.dart';

@dao
abstract class DeveloperDao {
  @insert
  Future<void> insertDeveloper(Developer developer);
}
