import 'package:gym_apk/domain/entities/usuario.dart';
import 'package:gym_apk/domain/repository/repo_inscripcion.dart';

class ObtenerUsuariosInscriptosCDU {
  final RepoInscripcion _repoInscripcion;
  ObtenerUsuariosInscriptosCDU(this._repoInscripcion);

  Future<List<Usuario>> execute(int idClase) async {
    if (idClase <= 0) {
      throw Exception("Id de clase inválido");
    }

    return await _repoInscripcion.obtenerUsuarioInscriptos(idClase);
  }
}
