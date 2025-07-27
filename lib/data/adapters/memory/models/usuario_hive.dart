import 'package:hive/hive.dart';

part 'usuario_hive.g.dart';

@HiveType(typeId: 0)
class UsuarioHive extends HiveObject {
  @HiveField(0)
  int idUsuario;

  @HiveField(1)
  String nombre;

  @HiveField(2)
  String apellido;

  @HiveField(3)
  String? correo;

  @HiveField(4)
  bool pago;

  @HiveField(5)
  DateTime? fechaDePago;

  UsuarioHive({
    required this.idUsuario,
    required this.nombre,
    required this.apellido,
    this.correo,
    required this.pago,
    this.fechaDePago,
  });
}
