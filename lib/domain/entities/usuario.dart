import 'package:gym_apk/domain/entities/rol.dart';

class Usuario {
  int idUsuario;
  String nombre;
  String apellido;
  String? correo;
  Rol? rol;
  Usuario(
      {required this.idUsuario,
      required this.nombre,
      required this.correo,
      required this.apellido,
      required this.rol});
  Usuario copyWith({
    String? nombre,
    String? apellido,
    String? correo,
    Rol? rol,
  }) {
    return Usuario(
        idUsuario: idUsuario,
        nombre: nombre ?? this.nombre,
        apellido: apellido ?? this.apellido,
        rol: rol ?? this.rol,
        correo: correo ?? this.correo);
  }
}
