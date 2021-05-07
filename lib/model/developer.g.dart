// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'developer.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeveloperAdapter extends TypeAdapter<Developer> {
  @override
  final int typeId = 1;

  @override
  Developer read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Developer(
      fields[0] as int?,
      fields[1] as DateTime,
      fields[2] as String,
      fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Developer obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.giantBombId)
      ..writeByte(1)
      ..write(obj.dateLastUpdated)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.country);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeveloperAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
