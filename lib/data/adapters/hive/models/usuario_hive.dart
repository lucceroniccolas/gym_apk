import 'package:hive/hive.dart';
import 'package:gym_apk/domain/entities/usuario.dart';
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

  // Convierte una entidad de dominio a un modelo de Hive
  factory UsuarioHive.fromEntity(Usuario usuario) {
    return UsuarioHive(
      idUsuario: usuario.idUsuario,
      nombre: usuario.nombre,
      apellido: usuario.apellido,
      correo: usuario.correo ?? usuario.correo,
      pago: usuario.pago,
      fechaDePago: usuario.fechaDePago ?? usuario.fechaDePago,
    );
  }
  Usuario toEntity() {
    return Usuario(
      idUsuario: idUsuario,
      nombre: nombre,
      apellido: apellido,
      correo: correo,
      pago: pago,
      fechaDePago: fechaDePago,
    );
  }
}
