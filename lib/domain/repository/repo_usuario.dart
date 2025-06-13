import '../entities/usuario.dart';
//import '../entities/rol.dart';

abstract class RepoUsuario {
  Future<void> crearUsuario(Usuario usuario);
  Future<void> borrarUsuario(int idUsuario);
  Future<void> modificarUsuario(int idUsuario, Usuario usuario);
  Future<List<Usuario>> obtenerTodosLosUsuarios();
  Future<Usuario?> obtenerUsuarioPorId(int idUsuario);
  Future<DateTime> actualizarFechadePago(int idUsuario);
}
