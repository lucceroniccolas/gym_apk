import 'package:gym_apk/domain/entities/usuario.dart';
import 'package:gym_apk/domain/repository/repo_usuario.dart';

class ModificarUsuarioCDU {
  final RepoUsuario _usuarioRepo;
  ModificarUsuarioCDU(this._usuarioRepo);

  Future<bool> execute(Usuario usuarioModificado) async {
    final idUsuario = usuarioModificado.idUsuario;
    if (idUsuario <= 0) {
      throw Exception("El usuario con id $idUsuario no es válido");
    }

    final usuarioExiste = await _usuarioRepo.obtenerUsuarioPorId(idUsuario);
    if (usuarioExiste == null) {
      throw Exception("El usuario no existe");
    }

    try {
      await _usuarioRepo.modificarUsuario(idUsuario, usuarioModificado);
      return true;
    } catch (e) {
      return false;
    }
  }
}
