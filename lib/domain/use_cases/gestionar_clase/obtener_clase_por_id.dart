import 'package:gym_apk/domain/repository/repo_clases.dart';
import 'package:gym_apk/domain/entities/clases.dart';

class ObtenerClasePorIdCDU {
  final RepoClases _repoClases;

  ObtenerClasePorIdCDU(this._repoClases);
  Future<Clase?> execute(int idClase) async {
    if (idClase <= 0) {
      throw Exception("El id de la Clase debe ser un valor positivo.");
    }
    return await _repoClases.obtenerClasePorId(idClase);
  }
}
