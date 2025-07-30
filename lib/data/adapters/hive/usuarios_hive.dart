import 'package:hive/hive.dart';
import 'package:gym_apk/domain/entities/usuario.dart';
import 'package:gym_apk/domain/repository/repo_usuario.dart';
import 'package:gym_apk/data/adapters/hive/models/usuario_hive.dart';

class HiveUsuarioImpl implements RepoUsuario {
  final Box<UsuarioHive> _box;
  HiveUsuarioImpl(this._box);

  Future<int> _getNextUsuarioId() async {
    final settingsBox = await Hive.openBox('settingsBox');
    final lastId = settingsBox.get("lastUsuarioId", defaultValue: 0) as int;
    final nextId = lastId + 1;
    await settingsBox.put("lastUsuarioId", nextId);
    return nextId;
  }

  @override
  Future<void> crearUsuario(Usuario usuario) async {
    final usuarioModel = UsuarioHive.fromEntity(usuario);
    usuarioModel.idUsuario = await _getNextUsuarioId();

    await _box.put(usuarioModel.idUsuario, usuarioModel);
  }

  @override
  Future<void> borrarUsuario(int idUsuario) async {
    await _box.delete(idUsuario);
  }

  @override
  Future<void> modificarUsuario(
      int idUsuario, Usuario usuarioModificado) async {
    await _box.put(idUsuario, UsuarioHive.fromEntity(usuarioModificado));
  }

  @override
  Future<List<Usuario>> obtenerTodosLosUsuarios() async {
    return _box.values.map((u) => u.toEntity()).toList();
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
