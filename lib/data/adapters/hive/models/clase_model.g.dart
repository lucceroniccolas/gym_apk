// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clase_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClaseHiveAdapter extends TypeAdapter<ClaseHive> {
  @override
  final int typeId = 1;

  @override
  ClaseHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ClaseHive(
      idClase: fields[0] as int,
      nombreClase: fields[1] as String,
      descripcion: fields[2] as String?,
      cupos: fields[3] as int,
      horario: fields[4] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, ClaseHive obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.idClase)
      ..writeByte(1)
      ..write(obj.nombreClase)
      ..writeByte(2)
      ..write(obj.descripcion)
      ..writeByte(3)
      ..write(obj.cupos)
      ..writeByte(4)
      ..write(obj.horario);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClaseHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
