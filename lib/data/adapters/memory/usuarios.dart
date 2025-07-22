import 'dart:collection';

import 'package:gym_apk/domain/entities/usuario.dart';
import 'package:gym_apk/domain/repository/repo_usuario.dart';

class MemoriaUsuarioImpl implements RepoUsuario {
  MemoriaUsuarioImpl();

  int _contadorId = 2;
  // Lista que guarda los usuarios cargados en memoria
  final List<Usuario> _usuarios = [
    Usuario(
        idUsuario: 1,
        nombre: "chimi",
        apellido: "changas",
        correo: "nicolashdgg@gmail.com",
        pago: true,
        fechaDePago: DateTime.now())
  ];

  @override
  Future<List<Usuario>> obtenerTodosLosUsuarios() async {
    return UnmodifiableListView(_usuarios);
  }

  @override
  Future<void> borrarUsuario(int idUsuario) async {
    _usuarios.removeWhere((usuario) => usuario.idUsuario == idUsuario);
  }

  @override
  Future<void> crearUsuario(Usuario usuario) async {
    usuario.idUsuario = _contadorId++;
    _usuarios.add(usuario);
    print(usuario.idUsuario);
  }

  @override
  Future<void> modificarUsuario(
      int idUsuario, Usuario usuarioModificado) async {
    final index = _usuarios.indexWhere((usuario) =>
        usuario.idUsuario ==
        idUsuario); //Busca el índice en la lista _usuarios usando el id del usuario que se quiere modificar.
    if (index != -1) {
      _usuarios[index] =
          usuarioModificado; // Si el índice existe (index != -1), actualiza el usuario en esa posición.
    }
  }

  @override
  Future<Usuario?> obtenerUsuarioPorId(int idUsuario) async {
    return _usuarios.where((usuario) => usuario.idUsuario == idUsuario).isEmpty
        ? null
        : _usuarios.firstWhere((u) => u.idUsuario == idUsuario);
  }
}
