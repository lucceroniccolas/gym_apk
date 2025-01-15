import 'package:gym_apk/domain/entities/rol.dart';

class Usuario {
  int idUsuario;
  String nombre;
  String apellido;
  Rol? rol;
  Usuario(
      {required this.idUsuario,
      required this.nombre,
      required this.apellido,
      required this.rol});
}
