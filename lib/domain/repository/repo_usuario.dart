import '../entities/usuario.dart';
//import '../entities/rol.dart';

//Las clases abstractas sirven para definir una interfaz, esto se aplica a los principios SOLID
//Las interfaces sirven para la implementación
//es decir, definimos una interfaz con las funciones que se utilizan
//Pero no definimos las funciones debido a que las mismas serán definidas en las implementaciones
//Ya sea en memoria, en firebase, sql, etc
abstract class RepoUsuario {
  Future<void> crearUsuario(Usuario usuario);
  Future<void> borrarUsuario(int idUsuario);
  Future<void> modificarUsuario(int idUsuario, Usuario usuario);
  Future<List<Usuario>> obtenerTodosLosUsuarios();
  Future<Usuario?> obtenerUsuarioPorId(int idUsuario);
}


//Por qué es Future<void>: Indica que la operación puede ser asincrónica 
//(como guardar datos en una base de datos).
// No devuelve valores, pero permite saber cuándo se completa.
