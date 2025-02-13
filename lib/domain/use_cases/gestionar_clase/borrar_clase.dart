import 'package:gym_apk/domain/repository/repo_clases.dart';

class EliminarClaseCDU {
  final RepoClases repoClases;
  EliminarClaseCDU(this.repoClases);

  Future<void> execute(int idClase) async {
    if (idClase == 0) {
      throw Exception("El ID de la clase no es válido");
    }
    await repoClases.borarClase(idClase);
  }
}
