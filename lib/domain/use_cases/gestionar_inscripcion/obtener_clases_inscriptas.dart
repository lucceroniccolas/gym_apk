import 'package:gym_apk/domain/entities/clases.dart';
import 'package:gym_apk/domain/repository/repo_inscripcion.dart';

class ObtenerClasesInscriptasCDU {
  final RepoInscripcion _repoInscripcion;
  ObtenerClasesInscriptasCDU(this._repoInscripcion);

  Future<List<Clase>> execute(int idUsuario) async {
    if (idUsuario <= 0) {
      throw Exception("Id  de usuario inválido.");
    }
    return await _repoInscripcion.obtenerClasesInscriptas(idUsuario);
  }
}
