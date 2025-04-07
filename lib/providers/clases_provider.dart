import 'package:gym_apk/domain/use_cases/gestionar_clase/borrar_clase.dart';
import 'package:gym_apk/domain/use_cases/gestionar_clase/modificar_clase.dart';
import 'package:gym_apk/domain/use_cases/gestionar_clase/obtener_clase_por_id.dart';
import 'package:gym_apk/domain/use_cases/gestionar_clase/obtener_horario_de_clase.dart';
import 'package:gym_apk/domain/use_cases/gestionar_clase/crear_clase.dart';
import 'package:gym_apk/domain/use_cases/gestionar_clase/obtener_clases.dart';
import 'package:gym_apk/domain/entities/clases.dart';
import 'package:flutter/material.dart';

class ClasesProvider extends ChangeNotifier {
  // Declaración de la clase Provider

  final CrearClaseCDU _crearClase; //Dependencia del Caso de Uso
  final BorrarClaseCDU _eliminarClase;
  final ModificarClaseCDU _modificarClase;
  final ObtenerClasePorIdCDU _obtenerClasePorId;
  final ObtenerTodasLasClasesCDU _obtenerTodasLasClases;
  final ObtenerHorarioPorIdDeClaseCDU _obtenerHorarioPorIdDeClase;

  ClasesProvider(
      //Constructor del Provider
      this._crearClase,
      this._eliminarClase, //dependecias
      this._modificarClase,
      this._obtenerClasePorId,
      this._obtenerHorarioPorIdDeClase,
      this._obtenerTodasLasClases);

  List<Clase> _clases =
      []; // lista privada que almacena todas las clases disponibles en el sistema.

  List<Clase> get clases =>
      _clases; // Getter público para obtener la lista de clases desde la UI (Esto permite acceder a _clases sin exponer la variable privada directamente.)

  Clase?
      _claseSeleccionada; //Guarda una clase específica seleccionada por el usuario.

  Clase?
      get claseSeleccionada => //Getter público para acceder a la clase seleccionada desde la UI.
          _claseSeleccionada;

  DateTime? _horarioClase; //Guarda el horario de la clase seleccionada.

  DateTime? get horarioClase =>
      _horarioClase; //Getter público para obtener el horario de la clase seleccionada.

  bool _isLoading =
      false; //Indica si una operación está en curso (como cargar clases o modificar datos).

  bool get isLoading =>
      _isLoading; //Getter público para saber si el Provider está realizando una operación.

  Future<bool> crearClase(Clase nuevaClase) async {
    _isLoading = true;
    notifyListeners();
    bool resultado = await _crearClase.execute(nuevaClase);
    if (resultado) {
      _clases.add(nuevaClase);
    }
    _isLoading = false;
    notifyListeners();
    return resultado;
  }

  Future<bool> eliminarClase(int idClase) async {
    _isLoading = true;
    notifyListeners();
    bool resultado = await _eliminarClase.execute(idClase);
    if (resultado) {
      _clases.removeWhere((c) => c.idClase == idClase);
    }
    _isLoading = false;
    notifyListeners();
    return resultado;
  }

  Future<bool> modificarClase(int idClase, Clase claseModificada) async {
    try {
      _isLoading = true;
      notifyListeners();
      bool resultado = await _modificarClase.execute(idClase, claseModificada);

      if (resultado) {
        _clases = await _obtenerTodasLasClases.execute(); //recargamos los datos
        notifyListeners();
      }
      return resultado;
    } catch (e) {
      print("Error al moidificar clase: $e");
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> obtenerClases() async {
    _isLoading = true;
    notifyListeners();
    try {
      _clases = await _obtenerTodasLasClases.execute();
    } catch (e) {
      _clases = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> obtenerClasePorId(idClase) async {
    _isLoading = true;
    notifyListeners();
    try {
      _claseSeleccionada = await _obtenerClasePorId.execute(idClase);
    } catch (e) {
      _claseSeleccionada = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> obtenerHorarioPorIdDeClase(int idClase) async {
    _isLoading = true;
    notifyListeners();
    try {
      _horarioClase = await _obtenerHorarioPorIdDeClase.execute(idClase);
    } catch (e) {
      _horarioClase = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
