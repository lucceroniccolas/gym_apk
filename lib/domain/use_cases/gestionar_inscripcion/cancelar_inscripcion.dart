import 'package:gym_apk/domain/repository/repo_inscripcion.dart';

class CancelarInscripcionCDU {
  final RepoInscripcion _repoInscripcion;
  CancelarInscripcionCDU(this._repoInscripcion);

  Future<void> execute(int idUsuario, int idClase) async {
    if (idUsuario <= 0 || idClase <= 0) {
      throw Exception("El id del usuario o clase no es válido.");
    }
    await _repoInscripcion.cancelarInscripcion(idUsuario, idClase);
  }
}
