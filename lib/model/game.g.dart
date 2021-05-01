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
      fields[0] as String,
      fields[1] as String,
      fields[2] as Uint8List?,
      (fields[3] as List).cast<Genre>(),
      fields[4] as String?,
      (fields[5] as List).cast<Release>(),
      (fields[6] as List).cast<Franchise>(),
    );
  }

  @override
  void write(BinaryWriter writer, Game obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.genres)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.releases)
      ..writeByte(6)
      ..write(obj.franchises);
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
