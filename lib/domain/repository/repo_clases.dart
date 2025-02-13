import 'package:gym_apk/domain/entities/clases.dart';

abstract class RepoClases {
  Future<void> crearClase(Clase clase);
  Future<void> borarClase(int idClase);
  Future<void> modificarClase(int idClase, Clase claseModificada);
  Future<List<Clase>> obtenerClases();
  Future<Clase?> obtenerClasePorId(int idClase);
  Future<DateTime?> obtenerHorariosPorIdClase(int idClase);
}
