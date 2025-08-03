import 'package:gym_apk/domain/repository/repo_usuario.dart';
import 'package:gym_apk/domain/services/coordinador_inscripciones.dart';

class EliminarUsuarioCDU {
  final RepoUsuario _repoUsuario;
  final CoordinadorInscripciones _coordinadorInscripciones;

  EliminarUsuarioCDU(this._repoUsuario, this._coordinadorInscripciones);

  Future<bool> execute(int idUsuario) async {
    if (idUsuario < 0) {
      throw Exception("El ID del usuario no es válido");
    }
    final usuarioExiste = await _repoUsuario.obtenerUsuarioPorId(idUsuario);
    if (usuarioExiste == null) {
      throw Exception("El usuario no existe");
    }

    try {
      await _coordinadorInscripciones
          .cancelarTodasLasInscripcionesDeUsuario(idUsuario);
      await _repoUsuario.borrarUsuario(idUsuario);
      return true;
    } catch (e) {
      return false;
    }
  }
}
