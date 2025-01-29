import 'package:gym_apk/domain/entities/permisos.dart';

abstract class RepoPermisos {
  Future<void> crearPermiso(Permiso permiso);
  Future<void> borarPermiso(int idPermiso);
  Future<void> modificarPermiso(Permiso permiso);
  Future<List<Permiso>> obtenerTodosLosPermisos();
  Future<Permiso?> obtenerPermisoPorId(int idPermiso);
}
