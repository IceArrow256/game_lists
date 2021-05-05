// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'walkthrough.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WalkthroughAdapter extends TypeAdapter<Walkthrough> {
  @override
  final int typeId = 7;

  @override
  Walkthrough read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Walkthrough(
      startDate: fields[0] as DateTime?,
      endDate: fields[1] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, Walkthrough obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.startDate)
      ..writeByte(1)
      ..write(obj.endDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WalkthroughAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
