import 'package:flutter/material.dart';
import 'package:gym_apk/domain/entities/clases.dart';
import 'package:gym_apk/domain/entities/usuario.dart';
import 'package:gym_apk/domain/entities/inscripcion.dart';
import 'package:gym_apk/domain/use_cases/gestionar_clase/obtener_clases.dart';
import 'package:gym_apk/domain/use_cases/gestionar_inscripcion/cancelar_inscripcion_cdu.dart';
import 'package:gym_apk/domain/use_cases/gestionar_inscripcion/inscribir_alumno_en_clase_cdu.dart';
import 'package:gym_apk/domain/use_cases/gestionar_inscripcion/obtener_clases_inscriptas_cdu.dart';
import 'package:gym_apk/domain/use_cases/gestionar_inscripcion/obtener_usuarios_inscriptos_cdu.dart';
import 'package:gym_apk/domain/use_cases/gestionar_inscripcion/obtener_inscripciones_cdu.dart';
import 'package:gym_apk/domain/use_cases/gestionar_usuario/obtener_todos_los_usuarios.dart';
import 'package:gym_apk/ui/models/inscripcion_detallada.dart';
import 'package:gym_apk/providers/clases_provider.dart';
import 'package:gym_apk/injection/injection_container.dart';

//Nota: las funciones en las cual cambiamos algo ya sea alta baja o modificación son funciones
//que devuelven booleanos porque nos ayudan a saber si tuvo éxito o falló y tambien pueden
//mostrar un mensaje en pantalla

//declaracion
class InscripcionProvider extends ChangeNotifier {
  final CancelarInscripcionCDU _cancelarInscripcion;
  final InscribirAlumnoEnClaseCDU _inscribirAlumnoEnClase;
  final ObtenerClasesInscriptasDeUsuarioCDU _obtenerClasesInscriptas;
  final ObtenerUsuariosInscriptosCDU _obtenerUsuariosInscriptos;
  final ObtenerInscripcionesCDU _obtenerInscripciones;
  final ObtenerTodosLosUsuariosCDU _obtenerTodosLosUsuarios;
  final ObtenerTodasLasClasesCDU _obtenerTodasLasClases;

//dependecias
  InscripcionProvider(
      this._cancelarInscripcion,
      this._inscribirAlumnoEnClase,
      this._obtenerClasesInscriptas,
      this._obtenerUsuariosInscriptos,
      this._obtenerInscripciones,
      this._obtenerTodosLosUsuarios,
      this._obtenerTodasLasClases);

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  Inscripcion? _inscripcionSeleccionada;
  Inscripcion? get inscripcionSeleccionada => _inscripcionSeleccionada;

  set inscripcionSeleccionada(Inscripcion? inscripcion) {
    _inscripcionSeleccionada = inscripcion;
    notifyListeners();
  }

  List<Inscripcion> _inscripciones = [];
  List<Inscripcion> get incripciones => _inscripciones;

  List<Usuario> _usuarios = [];
  List<Usuario> get usuarios => _usuarios;

  List<Clase> _clases = [];
  List<Clase> get clases => _clases;

  List<Clase> _inscripcionesUsuario = [];
  List<Clase> get inscripcionesUsuario => _inscripcionesUsuario;
  List<Usuario> _inscriptosEnClase = [];
  List<Usuario> get inscriptosEnClase => _inscriptosEnClase;

  Future<void> cargarDatos() async {
    _setLoading(true);
    _inscripciones = await _obtenerInscripciones.execute();
    _usuarios = await _obtenerTodosLosUsuarios.execute();
    _clases = await _obtenerTodasLasClases.execute();
    _setLoading(false);
  }

//Responsabilidad única, ya administra la lista de inscripciones
//separar inscripcion detallada me olbigará a duplicar las listas de clases usuarios e inscripciones

  List<InscripcionDetallada> get inscripcionesDetalladas {
    return _inscripciones.map((inscripcion) {
      final usuario =
          _usuarios.firstWhere((u) => u.idUsuario == inscripcion.idUsuario);
      final clase = _clases.firstWhere((c) => c.idClase == inscripcion.idClase);

      return InscripcionDetallada(
        idInscripcion: inscripcion.idInscripcion,
        idUsuario: inscripcion.idUsuario,
        idClase: inscripcion.idClase,
        nombreUsuario: usuario.nombre,
        nombreClase: clase.nombreClase,
        fechaInscripcion: inscripcion.fechaInscripcion,
        pago: usuario.pago,
      );
    }).toList();
  }

  Future<bool> inscribirAlumnoAClase(int idAlumno, int idClase) async {
    _setLoading(true);

    try {
      // Aseguramos que las clases estén actualizadas
      _clases = await _obtenerTodasLasClases.execute();

      //Buscamos la clase
      final clase = _clases.firstWhere(
        (c) => c.idClase == idClase,
        orElse: () => throw Exception("Clase no encontrada"),
      );

      //Verificamos cupos
      if (clase.cupos <= 0) {
        print("No hay cupos disponibles para esta clase");
        return false;
      }

      //Inscribimos
      await _inscribirAlumnoEnClase.execute(idAlumno, idClase);

      //Actualizamos los cupos en memoria
      final claseActualizada = Clase(
        idClase: clase.idClase,
        nombreClase: clase.nombreClase,
        descripcion: clase.descripcion,
        cupos: clase.cupos - 1,
        horario: clase.horario,
      );

      //Guardamos en la base
      await getIt<ClasesProvider>().actualizarClase(claseActualizada);


      //Refrescamos datos en memoria y UI
      await cargarDatos();
      notifyListeners();

      return true;
    } catch (e) {
      print("No se pudo inscribir el Alumno a la clase $e");
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> cancelarInscripcion(int idUsuario, int idClase) async {
  _setLoading(true);
  try {
    // 🔹 Aseguramos que las clases estén actualizadas
    _clases = await _obtenerTodasLasClases.execute();

    // 🔹 Buscamos la clase
    final clase = _clases.firstWhere(
      (c) => c.idClase == idClase,
      orElse: () => throw Exception("Clase no encontrada"),
    );

    // 🔹 Cancelamos la inscripción
    await _cancelarInscripcion.execute(idUsuario, idClase);

    // 🔹 Actualizamos los cupos en memoria
    final claseActualizada = Clase(
      idClase: clase.idClase,
      nombreClase: clase.nombreClase,
      descripcion: clase.descripcion,
      cupos: clase.cupos + 1,
      horario: clase.horario,
    );

    // 🔹 Guardamos en base de datos
    await getIt<ClasesProvider>().actualizarClase(claseActualizada);


    // 🔹 Refrescamos datos y UI
    await cargarDatos();
    notifyListeners();

    return true;
  } catch (e) {
    print("No se pudo cancelar la inscripcion $e");
    return false;
  } finally {
    _setLoading(false);
  }
}


  Future<void> obtenerInscriptosDeClase(int idUsuario) async {
    _setLoading(true);
    try {
      _inscriptosEnClase = await _obtenerUsuariosInscriptos.execute(idUsuario);
    } catch (e) {
      print("error al obtener inscriptos de la clase $e");
    } finally {
      _setLoading(false);
    }
  }

  Future<void> obtenerInscripcionesDeUsuario(int idUsuario) async {
    _setLoading(true);
    try {
      _inscripcionesUsuario = await _obtenerClasesInscriptas.execute(idUsuario);
    } catch (e) {
      print("error al obtener incripciones del usuario $e");
    } finally {
      _setLoading(false);
    }
  }

//manejo interno de loading
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
