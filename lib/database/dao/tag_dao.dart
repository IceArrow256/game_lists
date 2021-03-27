import 'package:floor/floor.dart';
import 'package:game_lists/database/entities/tag.dart';

@dao
abstract class TagDao {
  @insert
  Future<void> insertTag(Tag tag);
}