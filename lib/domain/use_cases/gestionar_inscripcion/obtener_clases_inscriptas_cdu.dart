import 'package:gym_apk/domain/entities/clases.dart';
import 'package:gym_apk/domain/repository/repo_clases.dart';
import 'package:gym_apk/domain/repository/repo_inscripcion.dart';

class ObtenerClasesInscriptasDeUsuarioCDU {
  final RepoClases _repoClases;
  final RepoInscripcion _repoInscripcion;
  ObtenerClasesInscriptasDeUsuarioCDU(this._repoClases, this._repoInscripcion);

  Future<List<Clase>> execute(int idUsuario) async {
    if (idUsuario < 0) {
      throw Exception("Id de usuario inválido.");
    }

    final inscripciones = await _repoInscripcion.obtenerInscripciones();
    final idsClases = inscripciones
        .where((i) => i.idUsuario == idUsuario)
        .map((i) => i.idClase)
        .toSet();

    final clases = <Clase>[];

    for (final id in idsClases) {
      final clase = await _repoClases.obtenerClasePorId(id);
      if (clase != null) clases.add(clase);
    }

    return clases;
  }
}
