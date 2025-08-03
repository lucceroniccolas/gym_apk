import 'package:gym_apk/domain/entities/clases.dart';
import 'package:gym_apk/domain/services/coordinador_inscripciones.dart';

class ObtenerClasesInscriptasDeUsuarioCDU {
  final CoordinadorInscripciones _coordinadorInscripciones;
  ObtenerClasesInscriptasDeUsuarioCDU(this._coordinadorInscripciones);

  Future<List<Clase>> execute(int idUsuario) async {
    if (idUsuario < 0) {
      throw Exception("Id  de usuario inválido.");
    }

    return await _coordinadorInscripciones
        .obtenerClasesInscriptasDeUsuario(idUsuario);
  }
}
