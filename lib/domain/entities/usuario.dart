import 'package:gym_apk/domain/entities/rol.dart';

class Usuario {
  int idUsuario;
  String nombre;
  String apellido;
  String? correo;
  Rol? rol;
  bool pago;
  DateTime? fechaDePago;
  Usuario(
      {required this.idUsuario,
      required this.nombre,
      required this.correo,
      required this.apellido,
      required this.rol,
      required this.pago,
      required this.fechaDePago});
  Usuario copyWith({
    String? nombre,
    String? apellido,
    String? correo,
    Rol? rol,
    bool? pago,
  }) {
    return Usuario(
        idUsuario: idUsuario,
        nombre: nombre ?? this.nombre,
        apellido: apellido ?? this.apellido,
        rol: rol ?? this.rol,
        correo: correo ?? this.correo,
        pago: pago ?? this.pago,
        fechaDePago: fechaDePago ?? this.fechaDePago);
  }
}
