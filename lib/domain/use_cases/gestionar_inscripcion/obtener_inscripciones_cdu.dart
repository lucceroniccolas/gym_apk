import 'package:gym_apk/domain/entities/inscripcion.dart';

import 'package:gym_apk/domain/repository/repo_inscripcion.dart';

class ObtenerInscripcionesCDU {
  final RepoInscripcion _repoInscripcion;
  ObtenerInscripcionesCDU(this._repoInscripcion);

  Future<List<Inscripcion>> execute() async {
    return await _repoInscripcion.obtenerInscripciones();
  }
}
