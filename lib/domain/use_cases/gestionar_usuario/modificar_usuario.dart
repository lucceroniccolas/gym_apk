import 'package:gym_apk/domain/entities/usuario.dart';
import 'package:gym_apk/domain/repository/repo_usuario.dart';

class ModificarUsuarioCDU {
  final RepoUsuario _usuarioRepo;
  ModificarUsuarioCDU(this._usuarioRepo);

  Future<bool> call(Usuario usuarioModificado) async {
    final usuarioExistente =
        await _usuarioRepo.obtenerUsuarioPorId(usuarioModificado.idUsuario);
    if (usuarioExistente == null) {
      throw Exception(
          "El usuario con id ${usuarioModificado.idUsuario} no existe");
    }
    try {
      await _usuarioRepo.crearUsuario(usuarioModificado);
      return true;
    } catch (e) {
      return false;
    }
  }
}
