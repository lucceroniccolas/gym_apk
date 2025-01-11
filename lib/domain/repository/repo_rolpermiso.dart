import "package:gym_apk/domain/entities/permisos.dart";
import "package:gym_apk/domain/entities/rol.dart";

abstract class RepoRolPermiso {
  Future<void> asignarPermisosAUnRol(int idRol, int idPermiso);
  Future<void> eliminarPermisosAUnRol(int idRol, int idPermiso);
  //Devuelve todos los permisos asociados a un rol
  Future<List<Permiso>> obtenerPermisosPorIdRol(int idRol);
  //Devuelve todos los roles asociados a un permiso específico
  Future<List<Rol>> obtenerRolesPorIdPermisos(int idPermiso);
}
