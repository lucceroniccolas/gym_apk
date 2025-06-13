import 'package:gym_apk/domain/entities/clases.dart';
import 'package:gym_apk/domain/entities/usuario.dart';
import 'package:gym_apk/domain/use_cases/gestionar_inscripcion/cancelar_inscripcion.dart';
import 'package:gym_apk/domain/use_cases/gestionar_inscripcion/inscribir_alumno_en_clase.dart';
import 'package:gym_apk/domain/use_cases/gestionar_inscripcion/obtener_clases_inscriptas.dart';
import 'package:gym_apk/domain/use_cases/gestionar_inscripcion/obtener_usuarios_inscriptos.dart';
import 'package:gym_apk/domain/use_cases/gestionar_inscripcion/obtener_inscripciones.dart';
import 'package:flutter/material.dart';
import 'package:gym_apk/domain/entities/inscripcion.dart';

//declaracion
class InscripcionProvider extends ChangeNotifier {
  final CancelarInscripcionCDU _cancelarInscripcion;
  final InscribirAlumnoEnClaseCDU _inscribirAlumnoEnClase;
  final ObtenerClasesInscriptasDeUsuarioCDU _obtenerClasesInscriptas;
  final obtenerUsuarioInscriptosDeClaseCDU _obtenerUsuariosInscriptos;
  final ObtenerInscripcionesCDU _obtenerInscripciones;

//dependecias
  InscripcionProvider(
      this._cancelarInscripcion,
      this._inscribirAlumnoEnClase,
      this._obtenerClasesInscriptas,
      this._obtenerUsuariosInscriptos,
      this._obtenerInscripciones);

  List<Inscripcion> _inscripciones = [];
  List<Inscripcion> get incripciones => _inscripciones;
  List<Clase> _inscripcionesUsuario = [];
  List<Clase> get inscripcionesUsuario => _inscripcionesUsuario;
  List<Usuario> _inscriptosEnClase = [];
  List<Usuario> get inscriptosEnClase => _inscriptosEnClase;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> cargarInscripciones() async {
    _isLoading = true;
    notifyListeners();
    _inscripciones = await _obtenerInscripciones.execute();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> inscribirAlumnoAClase(int idAlumno, int idClase) async {
    _isLoading = true;
    notifyListeners();
  }

  Future<void> cancelarInscripcion() async {
    _isLoading = true;
    notifyListeners();
  }

  Future<void> obtenerInscriptosDeClase(int idUsuario) async {
    _isLoading = true;
    notifyListeners();
    _inscriptosEnClase = await _obtenerUsuariosInscriptos.execute(idUsuario);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> obtenerInscripcionesDeUsuario(int idUsuario) async {
    _isLoading = true;
    notifyListeners();
    _inscripcionesUsuario = await _obtenerClasesInscriptas.execute(idUsuario);
    _isLoading = false;
    notifyListeners();
  }
}
