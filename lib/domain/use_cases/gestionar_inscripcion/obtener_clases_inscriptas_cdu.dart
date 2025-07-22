import 'package:gym_apk/domain/repository/repo_inscripcion.dart';
import 'package:gym_apk/domain/entities/clases.dart';

class ObtenerClasesInscriptasDeUsuarioCDU {
  final RepoInscripcion _repoInscripcion;
  ObtenerClasesInscriptasDeUsuarioCDU(this._repoInscripcion);

  Future<List<Clase>> execute(int idUsuario) async {
    if (idUsuario < 0) {
      throw Exception("Id  de usuario inválido.");
    }

    return await _repoInscripcion.obtenerClasesInscriptasDeUsuario(idUsuario);
  }
}
