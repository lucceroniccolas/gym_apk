// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuario_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UsuarioHiveAdapter extends TypeAdapter<UsuarioHive> {
  @override
  final int typeId = 0;

  @override
  UsuarioHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UsuarioHive(
      idUsuario: fields[0] as int,
      nombre: fields[1] as String,
      apellido: fields[2] as String,
      correo: fields[3] as String?,
      pago: fields[4] as bool,
      fechaDePago: fields[5] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, UsuarioHive obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.idUsuario)
      ..writeByte(1)
      ..write(obj.nombre)
      ..writeByte(2)
      ..write(obj.apellido)
      ..writeByte(3)
      ..write(obj.correo)
      ..writeByte(4)
      ..write(obj.pago)
      ..writeByte(5)
      ..write(obj.fechaDePago);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UsuarioHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
