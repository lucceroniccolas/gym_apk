import 'package:gym_apk/domain/entities/clases.dart';
import 'package:gym_apk/domain/entities/usuario.dart';
import 'package:gym_apk/domain/repository/repo_clases.dart';
import 'package:gym_apk/domain/repository/repo_inscripcion.dart';
import 'package:gym_apk/domain/repository/repo_usuario.dart';

class CancelarInscripcionCDU {
  final RepoInscripcion _repoInscripcion;
  final RepoClases _repoClases;
  final RepoUsuario _repoUsuario;

  CancelarInscripcionCDU(
      this._repoInscripcion, this._repoClases, this._repoUsuario);

  Future<void> execute(int idUsuario, int idClase) async {
    final clase = await _verificarClaseExiste(idClase);

    await _verificarInscripcionExiste(idUsuario, idClase);

    await _verificarUsuarioExiste(idUsuario);

    await _repoInscripcion.eliminarInscripcion(idUsuario, idClase);

    clase.cupos = (clase.cupos) + 1;

    await _repoClases.actualizarClase(clase);
  }

  Future<Usuario> _verificarUsuarioExiste(int idUsuario) async {
    final usuario = await _repoUsuario.obtenerUsuarioPorId(idUsuario);
    if (usuario == null) {
      throw Exception("El usuario con id $idUsuario no existe");
    }
    return usuario;
  }

  Future<void> _verificarInscripcionExiste(int idUsuario, int idClase) async {
    final claseInscriptas =
        await _repoInscripcion.obtenerClasesInscriptasDeUsuario(idUsuario);

    final estaInscripto = claseInscriptas.any((c) => c.idClase == idClase);
    if (!estaInscripto) {
      throw Exception("El usuario no está inscripto en esta clase");
    }
  }

  Future<Clase> _verificarClaseExiste(int idClase) async {
    final clase = await _repoClases.obtenerClasePorId(idClase);
    if (clase == null) {
      throw Exception("clase con ID $idClase no encontrada");
    }
    return clase;
  }
}
