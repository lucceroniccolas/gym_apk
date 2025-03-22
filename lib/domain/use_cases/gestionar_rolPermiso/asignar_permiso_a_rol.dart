import 'package:gym_apk/domain/repository/repo_rolpermiso.dart';

class AsignarPermisoARolCDU {
  final RepoRolPermiso repoRolPermiso;
  AsignarPermisoARolCDU(this.repoRolPermiso);

  Future<bool> execute(int idRol, int idPermiso) async {
    if (idRol <= 0 || idPermiso <= 0) {
      throw Exception("ID de Rol o Permiso  inválido.");
    }

    try {
      await repoRolPermiso.asignarPermisosAUnRol(idRol, idPermiso);

      return true;
    } catch (e) {
      return false;
    }
  }
}
