import 'package:gym_apk/domain/repository/repo_clases.dart';

class BorrarClaseCDU {
  final RepoClases repoClases;
  BorrarClaseCDU(this.repoClases);

  Future<bool> execute(int idClase) async {
    if (idClase == 0) {
      throw Exception("El ID de la clase no es válido");
    }

    final claseExiste = await repoClases.obtenerClasePorId(idClase);

    if (claseExiste == null) {
      throw Exception("Esta clase no existe");
    }
    try {
      await repoClases.borarClase(idClase);
      return true;
    } catch (e) {
      return false;
    }
  }
}
