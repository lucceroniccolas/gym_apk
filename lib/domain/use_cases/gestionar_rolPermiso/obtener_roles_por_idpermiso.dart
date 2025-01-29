import 'package:gym_apk/domain/entities/rol.dart';
import 'package:gym_apk/domain/repository/repo_rolpermiso.dart';

class ObtenerRolesPorIdpermisoCDU {
  final RepoRolPermiso repoRolPermiso;
  ObtenerRolesPorIdpermisoCDU(this.repoRolPermiso);

  Future<List<Rol>> execute(int idPermiso) async {
    if (idPermiso <= 0) {
      throw Exception("El id del permiso no es válido.");
    }
    return await repoRolPermiso.obtenerRolesPorIdPermisos(idPermiso);
  }
}
