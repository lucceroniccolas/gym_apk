import 'package:gym_apk/domain/repository/repo_clases.dart';
import 'package:gym_apk/domain/services/coordinador_inscripciones.dart';

class BorrarClaseCDU {
//Inyeccion de dependecia Manual
  final RepoClases repoClases;
  final CoordinadorInscripciones _coordinadorInscripciones;
  BorrarClaseCDU(this.repoClases,
      this._coordinadorInscripciones); //Permite que la clase no dependa de la implementacion DESACOPLA
//Inyeccion de dependecia Manual
  Future<bool> execute(int idClase) async {
    if (idClase < 0) {
      throw Exception("El ID de la clase no es válido");
    }
    final claseExiste = await repoClases.obtenerClasePorId(idClase);
    if (claseExiste == null) {
      throw Exception("Esta clase no existe");
    }
    try {
      await _coordinadorInscripciones
          .cancelarTodasLasInscripcionesDeClase(idClase);
      await repoClases.borarClase(idClase);
      return true;
    } catch (e) {
      return false;
    }
  }
}
