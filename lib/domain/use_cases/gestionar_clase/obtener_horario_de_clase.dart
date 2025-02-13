import 'package:gym_apk/domain/repository/repo_clases.dart';

class ObtenerHorarioPorIdDeClaseCDU {
  final RepoClases _repoClases;
  ObtenerHorarioPorIdDeClaseCDU(this._repoClases);
  Future<DateTime?> execute(int idClase) async {
    return await _repoClases.obtenerHorariosPorIdClase(idClase);
  }
}
