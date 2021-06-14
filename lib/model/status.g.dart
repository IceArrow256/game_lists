// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StatusAdapter extends TypeAdapter<Status> {
  @override
  final int typeId = 6;

  @override
  Status read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Status.playing;
      case 1:
        return Status.planning;
      case 2:
        return Status.completed;
      case 3:
        return Status.pause;
      case 4:
        return Status.dropped;
      default:
        return Status.playing;
    }
  }

  @override
  void write(BinaryWriter writer, Status obj) {
    switch (obj) {
      case Status.playing:
        writer.writeByte(0);
        break;
      case Status.planning:
        writer.writeByte(1);
        break;
      case Status.completed:
        writer.writeByte(2);
        break;
      case Status.pause:
        writer.writeByte(3);
        break;
      case Status.dropped:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
