import 'package:gym_apk/domain/repository/repo_inscripcion.dart';

class InscribirAlumnoEnClaseCDU {
  final RepoInscripcion _repoInscripcion;
  InscribirAlumnoEnClaseCDU(this._repoInscripcion);

  Future<bool> execute(int idUsuario, int idClase) async {
    if (idUsuario <= 0 || idClase <= 0) {
      throw Exception("Los IDs deben ser mayor a 0.");
    }

    try {
      await _repoInscripcion.inscribirUsuarioEnClase(idUsuario, idClase);
      return true;
    } catch (e) {
      return false;
    }
  }
}
