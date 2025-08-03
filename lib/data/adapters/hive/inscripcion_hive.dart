import 'package:hive/hive.dart';
import 'package:gym_apk/domain/entities/inscripcion.dart';
import 'package:gym_apk/domain/repository/repo_inscripcion.dart';
import 'package:gym_apk/data/adapters/hive/models/inscripcion_model.dart';

class HiveInscripcionImpl implements RepoInscripcion {
  final Box<InscripcionHive> _box;

  HiveInscripcionImpl(this._box);

  Future<int> _getNextInscripcionId() async {
    final settingsBox = await Hive.openBox('settingsBox');
    final lastId = settingsBox.get("lastInscripcionId", defaultValue: 0) as int;
    final nextId = lastId + 1;
    await settingsBox.put("lastInscripcionId", nextId);
    return nextId;
  }

  @override
  Future<List<Inscripcion>> obtenerInscripciones() async {
    return _box.values.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> agregarInscripcion(Inscripcion inscripcion) async {
    final nuevaInscripcion = InscripcionHive.fromEntity(inscripcion);
    nuevaInscripcion.idInscripcion = await _getNextInscripcionId();
    await _box.put(nuevaInscripcion.idInscripcion, nuevaInscripcion);
  }

  @override
  Future<void> eliminarInscripcion(int idUsuario, int idClase) {
    return _box.delete(idUsuario.toString() + idClase.toString());
  }
}
