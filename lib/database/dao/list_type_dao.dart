import 'package:floor/floor.dart';
import 'package:game_lists/database/entities/list_type.dart';

@dao
abstract class ListTypeDao {
  @insert
  Future<void> insertListType(ListType listType);
}