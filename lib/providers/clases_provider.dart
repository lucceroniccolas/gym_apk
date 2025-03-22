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
  final ObtenerHorarioPorIdDeClaseCDU _obtenerHorarioPorIdDeClaseCDU;

  ClasesProvider(
      //Constructor del Provider
      this._crearClase,
      this._eliminarClase, //dependecias
      this._modificarClase,
      this._obtenerClasePorId,
      this._obtenerHorarioPorIdDeClaseCDU,
      this._obtenerTodasLasClases);

  List<Clase> _clases = [];
  Clase? _claseSeleccionada;
  Clase? get claseSeleccionada =>
      _claseSeleccionada; //Esto permite acceder a _clases sin exponer la variable privada directamente.
  DateTime? _horarioClase;
  DateTime? get horarioClase => _horarioClase;
  List<Clase> get clases => _clases;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

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
    bool resultado = await _eliminarClase.execute(idClase);
    if (resultado) {
      _clases.removeWhere((c) => c.idClase == idClase);
    }
    _isLoading = false;
    notifyListeners();
    return resultado;
  }

  Future<bool> modificarClase(int idClase, Clase claseModificada) async {
    bool resultado = await _modificarClase.execute(idClase, claseModificada);
    if (resultado) {
      int index = _clases.indexWhere((c) => c.idClase == idClase);
      if (index != -1) {
        _clases[index] = claseModificada;
      }
    }
    _isLoading = false;
    notifyListeners();
    return resultado;
  }

  Future<void> obtenerClases() async {
    _isLoading = true;
    notifyListeners();
    try {
      _clases = await _obtenerTodasLasClases.execute();
    } catch (e) {
      _clases = [];
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> obtenerClasePorId(idClase) async {
    _isLoading = true;
    notifyListeners();
    try {
      _claseSeleccionada = await _obtenerClasePorId.execute(idClase);
    } catch (e) {
      _claseSeleccionada = null;
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> obtenerHorarioPorIdDeClase(int idClase) async {
    _isLoading = true;
    notifyListeners();
    try {
      _horarioClase = await _obtenerHorarioPorIdDeClaseCDU.execute(idClase);
    } catch (e) {
      _horarioClase = null;
    }
    _isLoading = false;
    notifyListeners();
  }
}
