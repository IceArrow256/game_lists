// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'release.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReleaseAdapter extends TypeAdapter<Release> {
  @override
  final int typeId = 5;

  @override
  Release read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Release(
      fields[0] as String,
      fields[1] as DateTime,
      (fields[2] as List).cast<Company>(),
      fields[3] as Platform,
    );
  }

  @override
  void write(BinaryWriter writer, Release obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.releaseDate)
      ..writeByte(2)
      ..write(obj.developers)
      ..writeByte(3)
      ..write(obj.platform);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReleaseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
