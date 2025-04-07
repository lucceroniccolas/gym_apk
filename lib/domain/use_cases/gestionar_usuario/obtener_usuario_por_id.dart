import 'package:gym_apk/domain/entities/usuario.dart';
import 'package:gym_apk/domain/repository/repo_usuario.dart';

class ObtenerUsuarioPorIdCDU {
  final RepoUsuario _repoUsuario;

  ObtenerUsuarioPorIdCDU(this._repoUsuario);
  Future<Usuario?> execute(int idUsuario) async {
    if (idUsuario <= 0) {
      throw Exception("El id del usuario debe ser un valor positivo.");
    }
    return await _repoUsuario.obtenerUsuarioPorId(idUsuario);
  }
}
