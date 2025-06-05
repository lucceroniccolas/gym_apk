import 'package:gym_apk/domain/entities/rol.dart';
import 'package:gym_apk/domain/repository/repo_roles.dart';

class ModificarRolCDU {
  final RepoRol repoRol;
  ModificarRolCDU(this.repoRol);

  Future<bool> execute(int idRol, Rol rolModificado) async {
    final rolExistente = await repoRol.obtenerRolPorID(rolModificado.idRol);
    if (rolExistente == null) {
      throw Exception("El Rol con id: ${rolModificado.idRol} no existe.");
    }

    try {
      await repoRol.crearRol(rolModificado);
      return true;
    } catch (e) {
      return false;
    }
  }
}
