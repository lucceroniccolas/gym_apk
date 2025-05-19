import 'package:gym_apk/domain/entities/rol.dart';
import 'package:gym_apk/domain/repository/repo_roles.dart';

class ObtenerRolPorIdCDU {
  final RepoRol _repoRol;

  ObtenerRolPorIdCDU(this._repoRol);
  Future<Rol?> execute(int idRol) async {
    if (idRol <= 0) {
      throw Exception("El id del Rol debe ser un valor positivo.");
    }
    return await _repoRol.obtenerRolPorID(idRol);
  }
}
