import 'package:gym_apk/domain/repository/repo_roles.dart';

class EliminarRolCDU {
  final RepoRol repoRol;
  EliminarRolCDU(this.repoRol);

  Future<bool> execute(int idRol) async {
    if (idRol == 0) {
      throw Exception("El ID del rol no es válido");
    }

    try {
      await repoRol.borrarRol(idRol);
      return true;
    } catch (e) {
      return false;
    }
  }
}
