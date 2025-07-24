import 'package:gym_apk/domain/repository/repo_inscripcion.dart';
import 'package:gym_apk/domain/repository/repo_usuario.dart';
import 'package:gym_apk/domain/use_cases/gestionar_inscripcion/cancelar_inscripcion_cdu.dart';

class EliminarUsuarioCDU {
  final RepoUsuario _repoUsuario;
  final RepoInscripcion _repoInscripcion;
  final CancelarInscripcionCDU _cancelarInscripcionCDU;
  EliminarUsuarioCDU(
      this._repoUsuario, this._repoInscripcion, this._cancelarInscripcionCDU);

  Future<bool> execute(int idUsuario) async {
    if (idUsuario < 0) {
      throw Exception("El ID del usuario no es válido");
    }
    final usuarioExiste = await _repoUsuario.obtenerUsuarioPorId(idUsuario);
    if (usuarioExiste == null) {
      throw Exception("El usuario no existe");
    }

    //obtenemos todas las clases inscriptas
    final clasesInscriptas =
        await _repoInscripcion.obtenerClasesInscriptasDeUsuario(idUsuario);
//cancelamos cada inscripcion para actualizar cupos
    for (final clase in clasesInscriptas) {
      await _cancelarInscripcionCDU.execute(idUsuario, clase.idClase);
    }
    //llamada al repositorio
    try {
      await _repoUsuario.borrarUsuario(idUsuario);
      return true;
    } catch (e) {
      return false;
    }
  }
}
