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
      giantBombId: fields[0] as int?,
      steamId: fields[1] as int?,
      dateLastUpdated: fields[3] as DateTime,
      name: fields[4] as String,
      image: fields[5] as Uint8List?,
      description: fields[6] as String?,
      releaseDate: fields[7] as DateTime?,
      developers: (fields[8] as List).cast<Developer>(),
      franchises: (fields[9] as List).cast<Franchise>(),
      genres: (fields[10] as List).cast<Genre>(),
      platforms: (fields[11] as List).cast<Platform>(),
      rating: fields[12] as int,
      notes: fields[13] as String,
      status: fields[14] as Status,
      walkthroughs: (fields[15] as List).cast<Walkthrough>(),
    )..dateAdded = fields[2] as DateTime;
  }

  @override
  void write(BinaryWriter writer, Game obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.giantBombId)
      ..writeByte(1)
      ..write(obj.steamId)
      ..writeByte(2)
      ..write(obj.dateAdded)
      ..writeByte(3)
      ..write(obj.dateLastUpdated)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.image)
      ..writeByte(6)
      ..write(obj.description)
      ..writeByte(7)
      ..write(obj.releaseDate)
      ..writeByte(8)
      ..write(obj.developers)
      ..writeByte(9)
      ..write(obj.franchises)
      ..writeByte(10)
      ..write(obj.genres)
      ..writeByte(11)
      ..write(obj.platforms)
      ..writeByte(12)
      ..write(obj.rating)
      ..writeByte(13)
      ..write(obj.notes)
      ..writeByte(14)
      ..write(obj.status)
      ..writeByte(15)
      ..write(obj.walkthroughs);
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
