import 'package:gym_apk/domain/entities/usuario.dart';
import 'package:gym_apk/domain/repository/repo_inscripcion.dart';
import 'package:gym_apk/domain/repository/repo_usuario.dart';

class ObtenerUsuariosInscriptosCDU {
  final RepoInscripcion _repoInscripcion;
  final RepoUsuario _repoUsuario;
  ObtenerUsuariosInscriptosCDU(this._repoInscripcion, this._repoUsuario);

  Future<List<Usuario>> execute(int idClase) async {
    if (idClase < 0) {
      throw Exception("Id de clase inválido");
    }
    final inscripciones = await _repoInscripcion.obtenerInscripciones();
    final idsUsuarios = inscripciones
        .where((i) => i.idClase == idClase)
        .map((i) => i.idUsuario)
        .toSet(); // evita duplicados

    final usuarios = <Usuario>[];

    for (final id in idsUsuarios) {
      final usuario = await _repoUsuario.obtenerUsuarioPorId(id);
      if (usuario != null) usuarios.add(usuario);
    }

    return usuarios;
  }
}
