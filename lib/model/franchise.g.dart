// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'franchise.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FranchiseAdapter extends TypeAdapter<Franchise> {
  @override
  final int typeId = 2;

  @override
  Franchise read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Franchise(
      fields[0] as int,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Franchise obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.giantBombId)
      ..writeByte(1)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FranchiseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
