import 'package:gym_apk/domain/entities/permisos.dart';
import '../entities/rol.dart';
abstract class RolRepo {
  Future<List<Rol>> obtenerTodosLosRoles();
  Future<Rol?> obtenerRolPorID(int idRol);
  Future<void> crearRol(Rol rol);
  Future<void> borrarRol(int idRol);
  Future<void> modificarRol(Rol rol);
  Future<List<Permiso>> obtenerPermisosPorRol(int idRol);
}
