import 'package:gym_apk/domain/repository/repo_permisos.dart';

class EliminarPermisoCDU {
  final RepoPermisos repoPermiso;
  EliminarPermisoCDU(this.repoPermiso);

  Future<bool> execute(int idPermiso) async {
    if (idPermiso <= 0) {
      throw Exception("El ID del Permiso no es válido");
    }
    //verificamos si el permiso existe antes de eliminarlo
    final permisoExistente = await repoPermiso.obtenerPermisoPorId(idPermiso);
    if (permisoExistente == null) {
      throw Exception("El permiso con ID $idPermiso no existe");
    }

    try {
      await repoPermiso.borarPermiso(idPermiso);
      return true;
    } catch (e) {
      return false;
    }
  }
}
