import 'package:gym_apk/domain/entities/permisos.dart';
import 'package:gym_apk/domain/repository/repo_permisos.dart';

class ObtenerPermisoPorIdCDU {
  final RepoPermisos _repoPermisos;

  ObtenerPermisoPorIdCDU(this._repoPermisos);
  Future<Permiso?> execute(int idPermiso) async {
    if (idPermiso <= 0) {
      throw Exception("El id del Permiso debe ser un valor positivo.");
    }
    return await _repoPermisos.obtenerPermisoPorId(idPermiso);
  }
}
