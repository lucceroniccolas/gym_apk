import 'package:gym_apk/ui/inscripciones/inscripcion_pantalla.dart';
import 'package:gym_apk/ui/inscripciones/cancelar_inscripcion.dart';
import 'package:gym_apk/ui/inscripciones/inscribir_alumno.dart';
import 'package:gym_apk/ui/inscripciones/mostrar_alumnos_inscriptos_a_clase.dart';
//import 'package:gym_apk/ui/inscripciones/mostrar_clases_inscriptas_del_alumno.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String home = "/";
  static const String gestionInscripciones = "/inscripciones";
  static const String inscribirAlumno = "/inscribirAlumno";
  static const String cancelarInscripcion = "/cancelarInscripcion";
  static const String mostarInscriptosDeClase = "/mostarInscriptos";
  static const String mostrarClasesInscriptasDeAlumno =
      "/mostrarClasesInscriptas";

  static Map<String, WidgetBuilder> routes = {
    gestionInscripciones: (context) => const InscripcionView(),
    inscribirAlumno: (context) => const InscribirAlumnoView(),
    cancelarInscripcion: (context) => const CancelarInscripcionView(),
    mostarInscriptosDeClase: (context) => const MostrarInscriptosView(),
    // mostrarClasesInscriptasDeAlumno: (context) =>
    //   const MostrarClasesInscriptasView(),
  };
}
