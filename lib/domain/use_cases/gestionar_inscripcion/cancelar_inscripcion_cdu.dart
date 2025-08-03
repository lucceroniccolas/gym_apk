import 'package:gym_apk/domain/services/coordinador_inscripciones.dart';

class CancelarInscripcionCDU {
  final CoordinadorInscripciones _coordinadorInscripciones;
  CancelarInscripcionCDU(this._coordinadorInscripciones);

  Future<void> execute(int idUsuario, int idClase) async {
    await _coordinadorInscripciones.cancelar(idUsuario, idClase);
  }
}
