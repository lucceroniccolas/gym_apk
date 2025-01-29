import 'package:gym_apk/domain/entities/permisos.dart';
import 'package:gym_apk/domain/repository/repo_rolpermiso.dart';

class ObtenerPermisosPorIdrolCDU {
  final RepoRolPermiso repoRolPermiso;
  ObtenerPermisosPorIdrolCDU(this.repoRolPermiso);

  Future<List<Permiso>> execute(int idRol) async {
    if (idRol <= 0) {
      throw Exception("ID de Rol inválido.");
    }
    return await repoRolPermiso.obtenerPermisosPorIdRol(idRol);
  }
}
