// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bus_route_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BusRouteModelAdapter extends TypeAdapter<BusRouteModel> {
  @override
  final int typeId = 0;

  @override
  BusRouteModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BusRouteModel(
      busName: fields[0] as String,
      startPoint: fields[1] as String,
      endPoint: fields[2] as String,
      isAc: fields[3] as bool,
      isCircular: fields[4] as bool,
      stops: (fields[5] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, BusRouteModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.busName)
      ..writeByte(1)
      ..write(obj.startPoint)
      ..writeByte(2)
      ..write(obj.endPoint)
      ..writeByte(3)
      ..write(obj.isAc)
      ..writeByte(4)
      ..write(obj.isCircular)
      ..writeByte(5)
      ..write(obj.stops);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BusRouteModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
