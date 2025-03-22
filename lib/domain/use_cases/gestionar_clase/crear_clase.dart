import 'package:gym_apk/domain/entities/clases.dart';
import 'package:gym_apk/domain/repository/repo_clases.dart';

class CrearClaseCDU {
  final RepoClases repoClases;
  CrearClaseCDU(this.repoClases);
  Future<bool> execute(Clase clase) async {
    if (clase.nombreClase.isEmpty || clase.horario is! DateTime) {
      throw Exception("El nombre de la clase y el horario son obligatorios");
    }

    try {
      await repoClases.crearClase(clase);
      return true;
    } catch (e) {
      return false;
    }
  }
}
