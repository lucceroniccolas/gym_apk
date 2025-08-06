import 'package:gym_apk/domain/entities/clases.dart';

//Las clases abstractas sirven para definir una interfaz, esto se aplica a los principios SOLID
//Las interfaces sirven para la implementación
//es decir, definimos una interfaz con las funciones que se utilizan
//Pero no definimos las funciones debido a que las mismas serán definidas en las implementaciones
//Ya sea en memoria, en firebase, sql, etc
abstract class RepoClases {
  Future<void> crearClase(Clase clase);
  Future<void> borarClase(int idClase);
  Future<void> modificarClase(int idClase, Clase claseModificada);
  Future<List<Clase>> obtenerClases();
  Future<Clase?> obtenerClasePorId(int idClase);
  Future<void> actualizarClase(Clase clase);
}
//qué hace Future<void>:
// Indica que la operación puede ser asincrónica
//(como guardar datos en una base de datos).
// No devuelve valores, pero permite saber cuándo se completa.
