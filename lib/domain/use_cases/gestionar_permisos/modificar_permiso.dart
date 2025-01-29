import 'package:gym_apk/domain/entities/permisos.dart';
import 'package:gym_apk/domain/repository/repo_permisos.dart';

class ModificarPermisoCDU {
  final RepoPermisos repoPermiso;
  ModificarPermisoCDU(this.repoPermiso);

  Future<void> execute(Permiso permisoModificado) async {
    final permisoExistente =
        await repoPermiso.obtenerPermisoPorId(permisoModificado.idPermiso);
    if (permisoExistente == null) {
      throw Exception(
          "El Permiso con id: ${permisoModificado.idPermiso} no existe.");
    }
    return await repoPermiso.crearPermiso(permisoModificado);
  }
}
