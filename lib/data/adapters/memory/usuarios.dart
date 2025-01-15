import 'dart:collection';

import 'package:gym_apk/domain/entities/usuario.dart';
import 'package:gym_apk/domain/repository/repo_usuario.dart';

class MemoriaUsuarioRepositorio implements RepoUsuario {
  static final MemoriaUsuarioRepositorio _instancia =
      MemoriaUsuarioRepositorio._privado();

  ///_instancia es una instancia estática privada que se crea solo una vez.

  //Constructor privado
  MemoriaUsuarioRepositorio._privado();

  // Factory para acceder a la instancia
  //Metodo para acceder a la instancia única
  factory MemoriaUsuarioRepositorio() {
    return _instancia;
  }

  // Lista que simula los usuarios cargados en memoria
  final List<Usuario> _usuarios = [];

  @override
  Future<List<Usuario>> obtenerTodosLosUsuarios() async {
    return UnmodifiableListView(_usuarios);
  }

  @override
  Future<void> borrarUsuario(int id) async {
    _usuarios.removeWhere((usuario) => usuario.idUsuario == id);
  }

  @override
  Future<void> crearUsuario(Usuario usuario) async {
    usuario.idUsuario = _usuarios.length + 1;
    _usuarios.add(usuario);
    print(usuario.nombre);
  }

  @override
  Future<void> modificarUsuario(Usuario usuarioModificado) async {
    final index = _usuarios.indexWhere((usuario) =>
        usuario.idUsuario ==
        usuarioModificado
            .idUsuario); //Busca el índice en la lista _usuarios usando el id del usuario que se quiere modificar.
    if (index != -1) {
      _usuarios[index] =
          usuarioModificado; // Si el índice existe (index != -1), actualiza el usuario en esa posición.
    } else {
      throw Exception(
          "Usuario con id ${usuarioModificado.idUsuario} no encontrado"); //Lanza una excepción si el usuario no existe, lo que permite a la capa superior manejar este error adecuadamente.
    }
  }

  @override
  Future<Usuario?> obtenerUsuarioPorId(int idUsuario) async {
    return _usuarios.firstWhere((usuario) => usuario.idUsuario == idUsuario);
  }
}
