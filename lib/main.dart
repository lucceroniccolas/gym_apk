import 'package:gym_apk/data/adapters/memory/usuarios.dart';
import 'package:gym_apk/domain/entities/usuario.dart';

Future<void> main() async {
  final repositorioUsuario = MemoriaUsuarioImpl();

//CREANDO ROLES

//CREANDO USUARIO

  repositorioUsuario.crearUsuario(Usuario(
      idUsuario: 1,
      nombre: "Diegoloso",
      apellido: "rodriguez",
      rol: null,
      correo: 'nicoolashddgg@gmial.cosm'));
  print("creado con exito");

//TODOS LOS USUARIOS

  List<Usuario> todosLosUsuarios =
      await repositorioUsuario.obtenerTodosLosUsuarios();

//FUNCION PARA MOSTRAR TODOS LOS USUARIOS

  todosLosUsuarios.forEach((user) {
    print(
        "ID: ${user.idUsuario}, Nombre: ${user.nombre}, Apellido: ${user.apellido}, Rol: ${user.rol}");
  });

//SIMULACION DE USUARIO A ENCONTRAR

  var usuarioAEncontrar = await repositorioUsuario.obtenerUsuarioPorId(2);

  if (usuarioAEncontrar != null) {
    print(
        "El nombre del usuario es ${usuarioAEncontrar.nombre} y el apellido es: ${usuarioAEncontrar.apellido}");
  } else {
    print("Usuario no encontrado.");
  }
// BORRANDO USUARIO
  try {
    await repositorioUsuario.borrarUsuario(3);
    print("Usuario borrado con éxito");
  } catch (e) {
    "El usuario no se encontró";
  }

// VOLVIENDO A MOSTRAR USUARIO
  todosLosUsuarios.forEach((user) {
    print(
        "ID: ${user.idUsuario}, Nombre: ${user.nombre}, Apellido: ${user.apellido}, Rol: ${user.rol}");
  });
  // try {
  //    await modificarUsuario(
  //        Usuario(idUsuario: 3, nombre: "Juan", apellido: "Lucero", rol: null));
  //    print("Usuario Modificado ");
  //  } catch (e) {
  //    print("Error: el diablo");
  //  }
}
