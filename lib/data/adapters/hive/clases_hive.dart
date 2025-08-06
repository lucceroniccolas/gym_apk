import 'package:hive/hive.dart';
import 'package:gym_apk/domain/entities/clases.dart';
import 'package:gym_apk/domain/repository/repo_clases.dart';
import 'package:gym_apk/data/adapters/hive/models/clase_model.dart';

class HiveClasesImpl implements RepoClases {
  final Box<ClaseHive> _box;
  HiveClasesImpl(this._box);

  Future<int> _getNextClaseId() async {
    final settingsBox = await Hive.openBox('settingsBox');
    final lastId = settingsBox.get("lastClaseId", defaultValue: 0) as int;
    final nextId = lastId + 1;
    await settingsBox.put("lastClaseId", nextId);
    return nextId;
  }

  @override
  Future<void> crearClase(Clase nuevaClase) async {
    final claseModel = ClaseHive.fromEntity(nuevaClase);
    claseModel.idClase = await _getNextClaseId();

    await _box.put(claseModel.idClase, claseModel);
  }

  @override
  Future<void> actualizarClase(Clase claseActulizada) async {
    final modelClase = ClaseHive.fromEntity(claseActulizada);
    await _box.put(modelClase.idClase, modelClase);
  }

  @override
  Future<void> borarClase(int idClase) async {
    await _box.delete(idClase);
  }

  @override
  Future<void> modificarClase(int idClase, Clase claseModificada) async {
    await _box.put(idClase, ClaseHive.fromEntity(claseModificada));
  }

  @override
  Future<Clase?> obtenerClasePorId(int idClase) async {
    final modelClase = _box.get(idClase);
    return modelClase?.toEntity();
  }

  @override
  Future<List<Clase>> obtenerClases() async {
    return _box.values.map((model) => model.toEntity()).toList();
  }
}
