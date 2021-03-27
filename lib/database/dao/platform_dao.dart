import 'package:floor/floor.dart';
import 'package:game_lists/database/entities/platform.dart';

@dao
abstract class PlatformDao {
  @insert
  Future<void> insertPlatform(Platform platform);
}