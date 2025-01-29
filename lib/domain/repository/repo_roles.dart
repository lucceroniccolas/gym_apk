import '../entities/rol.dart';

abstract class RepoRol {
  Future<void> crearRol(Rol rol);
  Future<void> borrarRol(int idRol);
  Future<void> modificarRol(Rol rol);
  Future<List<Rol>> obtenerTodosLosRoles();
  Future<Rol?> obtenerRolPorID(int idRol);
}
