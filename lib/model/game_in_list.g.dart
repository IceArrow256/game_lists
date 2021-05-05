// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_in_list.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GameInListAdapter extends TypeAdapter<GameInList> {
  @override
  final int typeId = 5;

  @override
  GameInList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GameInList(
      fields[0] as Game,
      fields[1] as int,
      fields[2] as String,
      fields[3] as Status,
      (fields[4] as List).cast<Walkthrough>(),
    );
  }

  @override
  void write(BinaryWriter writer, GameInList obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.game)
      ..writeByte(1)
      ..write(obj.rating)
      ..writeByte(2)
      ..write(obj.notes)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.walkthroughs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameInListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
