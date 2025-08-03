// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inscripcion_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InscripcionHiveAdapter extends TypeAdapter<InscripcionHive> {
  @override
  final int typeId = 2;

  @override
  InscripcionHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InscripcionHive(
      idInscripcion: fields[0] as int,
      idUsuario: fields[1] as int,
      fechaInscripcion: fields[3] as DateTime,
      idClase: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, InscripcionHive obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.idInscripcion)
      ..writeByte(1)
      ..write(obj.idUsuario)
      ..writeByte(2)
      ..write(obj.idClase)
      ..writeByte(3)
      ..write(obj.fechaInscripcion);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InscripcionHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
