import 'package:gym_apk/domain/services/coordinador_inscripciones.dart';

class InscribirAlumnoEnClaseCDU {
  final CoordinadorInscripciones _coordinadorInscripciones;
  InscribirAlumnoEnClaseCDU(this._coordinadorInscripciones);

  Future<void> execute(int idUsuario, int idClase) async {
    await _coordinadorInscripciones.inscribir(idUsuario, idClase);
  }
}
