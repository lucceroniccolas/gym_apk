import 'package:gym_apk/data/adapters/memory/usuarios.dart';
import 'package:gym_apk/domain/entities/usuario.dart';

import 'package:gym_apk/domain/use_cases/gestionar_usuario/modificar_usuario.dart';

Future<void> main() async {
  final repositorio = MemoriaUsuarioRepositorio();

  final modificarUsuario = ModificarUsuarioCDU(repositorio);

  await repositorio.crearUsuario(
      Usuario(idUsuario: 1, nombre: "Nicolas", apellido: "Lucero", rol: null));

  try {
    await modificarUsuario(
        Usuario(idUsuario: 1, nombre: "Juan", apellido: "Lucero", rol: null));
    print("Usuario Modificado ");
  } catch (e) {
    print("Error: el diablo");
  }
}
