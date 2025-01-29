import 'package:gym_apk/domain/entities/permisos.dart';
import 'package:gym_apk/domain/repository/repo_permisos.dart';

class ObtenerTodosLosPermisosCDU {
  final RepoPermisos repoPermisos;
  ObtenerTodosLosPermisosCDU(this.repoPermisos);

  Future<List<Permiso>> execute() async {
    return await repoPermisos.obtenerTodosLosPermisos();
  }
}
