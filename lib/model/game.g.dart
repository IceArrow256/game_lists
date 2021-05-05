// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GameAdapter extends TypeAdapter<Game> {
  @override
  final int typeId = 0;

  @override
  Game read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Game(
      fields[0] as int,
      fields[1] as DateTime,
      fields[2] as String,
      fields[3] as String,
      fields[4] as String?,
      fields[5] as DateTime?,
      (fields[6] as List).cast<Developer>(),
      (fields[7] as List).cast<Franchise>(),
      (fields[8] as List).cast<Genre>(),
      (fields[9] as List).cast<Platform>(),
    );
  }

  @override
  void write(BinaryWriter writer, Game obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.giantBombId)
      ..writeByte(1)
      ..write(obj.dateLastUpdated)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.imageUrl)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.releaseDate)
      ..writeByte(6)
      ..write(obj.developers)
      ..writeByte(7)
      ..write(obj.franchises)
      ..writeByte(8)
      ..write(obj.genres)
      ..writeByte(9)
      ..write(obj.platforms);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
