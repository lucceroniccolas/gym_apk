import 'package:gym_apk/domain/entities/permisos.dart';
import 'package:gym_apk/domain/entities/rol.dart';

class RolPermiso {
  final Rol rol;
  final Permiso permiso;

  RolPermiso({
    required this.rol,
    required this.permiso,
  });
}
