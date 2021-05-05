import 'package:game_lists/model/game.dart';
import 'package:game_lists/model/walkthrough.dart';
import 'package:hive/hive.dart';
import 'package:game_lists/model/status.dart';

part 'game_in_list.g.dart';

@HiveType(typeId: 5)
class GameInList extends HiveObject {
  @HiveField(0)
  Game game;

  @HiveField(1)
  int rating;

  @HiveField(2)
  String notes;

  @HiveField(3)
  Status status;

  @HiveField(4)
  List<Walkthrough> walkthroughs;

  GameInList(
      this.game, this.rating, this.notes, this.status, this.walkthroughs);
}
