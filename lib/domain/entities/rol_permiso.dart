import 'package:gym_apk/domain/entities/permisos.dart';
import 'package:gym_apk/domain/entities/rol.dart';

class RolPermiso {
  final Rol idrol;
  final Permiso idpermiso;

  RolPermiso({
    required this.idrol,
    required this.idpermiso,
  });
}
