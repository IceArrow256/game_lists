import 'package:floor/floor.dart';
import 'package:game_list/db/model/game_in_list.dart';

class DateTimeConverter extends TypeConverter<DateTime, int> {
  @override
  DateTime decode(int databaseValue) {
    return DateTime.fromMillisecondsSinceEpoch(databaseValue);
  }

  @override
  int encode(DateTime value) {
    return value.millisecondsSinceEpoch;
  }
}

class StatusConverter extends TypeConverter<Status, int> {
  @override
  Status decode(int databaseValue) {
    return Status.values[databaseValue];
  }

  @override
  int encode(Status value) {
    return value.index;
  }
}
