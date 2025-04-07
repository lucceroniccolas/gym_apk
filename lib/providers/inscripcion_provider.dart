import 'package:gym_apk/domain/use_cases/gestionar_inscripcion/cancelar_inscripcion.dart';
import 'package:gym_apk/domain/use_cases/gestionar_inscripcion/inscribir_alumno_en_clase.dart';
import 'package:gym_apk/domain/use_cases/gestionar_inscripcion/obtener_clases_inscriptas.dart';
import 'package:gym_apk/domain/use_cases/gestionar_inscripcion/obtener_usuarios_inscriptos.dart';
import 'package:flutter/material.dart';
import 'package:gym_apk/domain/entities/inscripcion.dart';

//declaracion
class InscripcionProvider extends ChangeNotifier {
  final CancelarInscripcionCDU _cancelarInscripcion;
  final InscribirAlumnoEnClaseCDU _inscribirAlumnoEnClase;
  final ObtenerClasesInscriptasCDU _obtenerClasesInscriptasCDU;
  final ObtenerUsuariosInscriptosCDU _obtenerClasesInscriptas;

//dependecias
  InscripcionProvider(this._cancelarInscripcion, this._inscribirAlumnoEnClase,
      this._obtenerClasesInscriptas, this._obtenerClasesInscriptasCDU);
}
