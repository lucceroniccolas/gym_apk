import 'package:gym_apk/domain/repository/repo_rolpermiso.dart';

class EliminarPermisoDeRolCDU {
  final RepoRolPermiso repoRolPermiso;
  EliminarPermisoDeRolCDU(this.repoRolPermiso);

  Future<bool> execute(int idRol, int idPermiso) async {
    if (idRol <= 0 || idPermiso <= 0) {
      throw Exception("Id de rol o Permiso invá");
    }

    try {
      await repoRolPermiso.eliminarPermisosAUnRol(idRol, idPermiso);
      return true;
    } catch (e) {
      return false;
    }
  }
}
