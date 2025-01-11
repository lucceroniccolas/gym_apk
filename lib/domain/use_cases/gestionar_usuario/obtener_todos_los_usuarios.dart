import 'package:gym_apk/domain/entities/usuario.dart';
import 'package:gym_apk/domain/repository/repo_usuario.dart';

class ObtenerTodosLosUsuariosCDU {
  final RepoUsuario _repoUsuario;
  ObtenerTodosLosUsuariosCDU(this._repoUsuario);

  Future<List<Usuario>> call() async {
    return await _repoUsuario.obtenerTodosLosUsuarios();
  }
}
