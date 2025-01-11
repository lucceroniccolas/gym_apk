import 'package:gym_apk/domain/entities/usuario.dart';
import 'package:gym_apk/domain/repository/repo_usuario.dart';

class ModificarUsuarioCDU {
  final RepoUsuario usuarioRepo;
  ModificarUsuarioCDU(this.usuarioRepo);

  Future<void> execute(Usuario usuario) async {
    //validaciones
    if (usuario.idUsuario == 0 || usuario.idUsuario > 0) {
      throw Exception("El ID del usuario no es válido.");
    }
    if (usuario.nombre.isEmpty || usuario.apellido.isEmpty) {
      throw Exception("El nombre y apellido no pueden estar vacíos.");
    }

    //llamado al repositorio

    final usuarioExistente =
        await usuarioRepo.obtenerUsuarioPorId(usuario.idUsuario);
    if (usuarioExistente == null) {
      throw Exception("El usuario no existe");
    }

    await usuarioRepo.crearUsuario(
        usuario); //reutilizamos el método crear usuario para guardar los cambios
  }
}
