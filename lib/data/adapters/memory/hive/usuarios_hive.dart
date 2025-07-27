import 'package:gym_apk/domain/entities/usuario.dart';
import 'package:gym_apk/domain/repository/repo_usuario.dart';
import 'package:hive/hive.dart';
import 'package:gym_apk/data/adapters/memory/models/usuario_hive.dart';

class HiveUsuarioImpl implements RepoUsuario {
  final Box<UsuarioHive> _box;
  HiveUsuarioImpl(this._box);
  
  @override
  Future<void> crearUsuario(Usuario usuario) async {
    final id = _box.length + 1;
    final nuevo = UsuarioHive(
      idUsuario: id,
      nombre: usuario.nombre,
      apellido: usuario.apellido,
      correo: usuario.correo,
      pago: usuario.pago,
      fechaDePago: usuario.fechaDePago,
    );
    await _box.put(id, nuevo);
  }

  @override
  Future<void> borrarUsuario(int idUsuario) async {
    await _box.delete(idUsuario);
  }

  @override
  Future<void> modificarUsuario(int idUsuario, Usuario usuario) async {
    final actualizado = UsuarioHive(
      idUsuario: idUsuario,
      nombre: usuario.nombre,
      apellido: usuario.apellido,
      correo: usuario.correo,
      pago: usuario.pago,
      fechaDePago: usuario.fechaDePago,
    );
    await _box.put(idUsuario, actualizado);
  }

  @override
  Future<List<Usuario>> obtenerTodosLosUsuarios() async {
    return _box.values.map((u) => Usuario(
      idUsuario: u.idUsuario,
      nombre: u.nombre,
      apellido: u.apellido,
      correo: u.correo,
      pago: u.pago,
      fechaDePago: u.fechaDePago,
    )).toList();
  }

  @override
  Future<Usuario?> obtenerUsuarioPorId(int idUsuario) async {
    final u = _box.get(idUsuario);
    if (u == null) return null;
    return Usuario(
      idUsuario: u.idUsuario,
      nombre: u.nombre,
      apellido: u.apellido,
      correo: u.correo,
      pago: u.pago,
      fechaDePago: u.fechaDePago,
    );
  }
}
