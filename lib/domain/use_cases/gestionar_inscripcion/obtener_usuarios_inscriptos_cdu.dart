import 'package:gym_apk/domain/entities/usuario.dart';
import 'package:gym_apk/domain/services/coordinador_inscripciones.dart';

class ObtenerUsuariosInscriptosCDU {
  final CoordinadorInscripciones _coordinadorInscripciones;
  ObtenerUsuariosInscriptosCDU(this._coordinadorInscripciones);

  Future<List<Usuario>> execute(int idClase) async {
    if (idClase < 0) {
      throw Exception("Id de clase inválido");
    }

    return await _coordinadorInscripciones
        .obtenerUsuariosInscriptosDeClase(idClase);
  }
}
