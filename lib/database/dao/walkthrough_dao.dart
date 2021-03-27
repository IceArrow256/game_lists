import 'package:floor/floor.dart';
import 'package:game_lists/database/entities/walkthrough.dart';

@dao
abstract class WalkthroughDao {
  @insert
  Future<void> insertWalkthrough(Walkthrough walkthrough);
}