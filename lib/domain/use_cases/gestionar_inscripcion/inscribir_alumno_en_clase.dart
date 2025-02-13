import 'package:gym_apk/domain/repository/repo_inscripcion.dart';

class InscribirAlumnoEnClaseCDU {
  final RepoInscripcion _repoInscripcion;
  InscribirAlumnoEnClaseCDU(this._repoInscripcion);

  Future<void> execute(int idUsuario, int idClase) async {
    if (idUsuario <= 0 || idClase <= 0) {
      throw Exception("id de usuario o clase inválidos.");
    }
    await _repoInscripcion.inscribirUsuarioEnClase(idUsuario, idClase);
  }
}
