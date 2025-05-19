import 'dart:collection';

import 'package:gym_apk/domain/entities/usuario.dart';
import 'package:gym_apk/domain/repository/repo_usuario.dart';

class MemoriaUsuarioImpl implements RepoUsuario {
  MemoriaUsuarioImpl();

  // Lista que guarda los usuarios cargados en memoria
  final List<Usuario> _usuarios = [
    Usuario(
        idUsuario: 3,
        nombre: "chimi",
        apellido: "changas",
        correo: "nicolashdgg@gmail.com",
        rol: null,
        pago: true)
  ];

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
  }

  @override
  Future<void> modificarUsuario(
      int idUsuario, Usuario usuarioModificado) async {
    final index = _usuarios.indexWhere((usuario) =>
        usuario.idUsuario ==
        idUsuario); //Busca el índice en la lista _usuarios usando el id del usuario que se quiere modificar.
    if (index != -1) {
      if (usuarioModificado.idUsuario != idUsuario) {
        throw Exception("No se puede modificar el ID del usuario");
      }
      _usuarios[index] = _usuarios[index].copyWith(
          nombre: usuarioModificado.nombre ?? _usuarios[index].nombre,
          apellido: usuarioModificado.apellido ?? _usuarios[index].apellido,
          correo: usuarioModificado.correo ?? _usuarios[index].correo,
          rol: usuarioModificado.rol ??
              _usuarios[index]
                  .rol); // Si el índice existe (index != -1), actualiza el usuario en esa posición.
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
