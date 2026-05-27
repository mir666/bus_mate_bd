// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stop_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StopModelAdapter extends TypeAdapter<StopModel> {
  @override
  final int typeId = 1;

  @override
  StopModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StopModel(
      name: fields[0] as String,
      latitude: fields[1] as double,
      longitude: fields[2] as double,
      area: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, StopModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.latitude)
      ..writeByte(2)
      ..write(obj.longitude)
      ..writeByte(3)
      ..write(obj.area);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StopModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
