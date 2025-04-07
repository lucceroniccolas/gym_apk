import 'package:gym_apk/domain/entities/usuario.dart';
import 'package:gym_apk/domain/repository/repo_usuario.dart';

class ModificarUsuarioCDU {
  final RepoUsuario _usuarioRepo;
  ModificarUsuarioCDU(this._usuarioRepo);

  Future<bool> execute(int idUsuario, Usuario usuarioModificado) async {
    if (idUsuario <= 0) {
      throw Exception("El usuario con id ${idUsuario} no es válido");
    }

    final usuarioExiste = await _usuarioRepo.obtenerUsuarioPorId(idUsuario);
    if (usuarioExiste == null) {
      throw Exception("El usuario no existe");
    }

    try {
      usuarioModificado.idUsuario =
          idUsuario; //aseguramos que mantiene el mismo ID
      await _usuarioRepo.modificarUsuario(idUsuario, usuarioModificado);
      return true;
    } catch (e) {
      return false;
    }
  }
}
