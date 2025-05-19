//¿Qué es get_it?

//patrón de diseño que centraliza la creación y acceso de servicios

//Inyectar dependencias sin pasar objetos a mano.
//Reducir acoplamiento entre capas.
//Mejorar testeo y escalabilidad.

//Hace más fácil el testing.
//Limpia el codigo en el main y en los providers

//paquete get_it
import 'package:get_it/get_it.dart';
//---Repositorios---
import 'package:gym_apk/domain/repository/repo_usuario.dart';
import 'package:gym_apk/domain/repository/repo_clases.dart';
//casos de uso
//----Usuario----
import 'package:gym_apk/domain/use_cases/gestionar_usuario/eliminar_usuario.dart';
import 'package:gym_apk/domain/use_cases/gestionar_usuario/crear_usuario.dart';
import 'package:gym_apk/domain/use_cases/gestionar_usuario/modificar_usuario.dart';
import 'package:gym_apk/domain/use_cases/gestionar_usuario/obtener_usuario_por_id.dart';
import 'package:gym_apk/domain/use_cases/gestionar_usuario/obtener_todos_los_usuarios.dart';
//---Clase---
// Casos de uso
import 'package:gym_apk/domain/use_cases/gestionar_clase/borrar_clase.dart';
import 'package:gym_apk/domain/use_cases/gestionar_clase/crear_clase.dart';
import 'package:gym_apk/domain/use_cases/gestionar_clase/modificar_clase.dart';
import 'package:gym_apk/domain/use_cases/gestionar_clase/obtener_clase_por_id.dart';
import 'package:gym_apk/domain/use_cases/gestionar_clase/obtener_clases.dart';
import 'package:gym_apk/domain/use_cases/gestionar_clase/obtener_horario_de_clase.dart';

//---Providers---
import 'package:gym_apk/providers/usuario_provider.dart';
import 'package:gym_apk/providers/clases_provider.dart';

//Adaptadores
import 'package:gym_apk/data/adapters/memory/usuarios.dart';
import 'package:gym_apk/data/adapters/memory/clases.dart';

final getIt = GetIt.instance;

///Nota:
///No se instancian providers porque pertenece a la capa de presentación y
///esta capa NO debe mezclarse con la logica de dominio o infraestructura.
void setupDependecies() {
  //ADAPTADORES
  //Instancia única "perezosa" (adaptadores)
  getIt.registerLazySingleton<RepoUsuario>(() => MemoriaUsuarioImpl());
  getIt.registerSingleton<RepoClases>(MemoriaClasesImpl());
// CASOS DE USO
  //Instancia nueva cada vez que se pide
  getIt.registerLazySingleton(() => CrearusuarioCDU(getIt<RepoUsuario>()));
  getIt.registerLazySingleton(() => ModificarUsuarioCDU(getIt<RepoUsuario>()));
  getIt.registerLazySingleton(
      () => ObtenerUsuarioPorIdCDU(getIt<RepoUsuario>()));
  getIt.registerLazySingleton(() => EliminarUsuarioCDU(getIt<RepoUsuario>()));
  getIt.registerLazySingleton(
      () => ObtenerTodosLosUsuariosCDU(getIt<RepoUsuario>()));
  getIt.registerLazySingleton(() => CrearClaseCDU(getIt()));
  getIt.registerLazySingleton(() => BorrarClaseCDU(getIt()));
  getIt.registerLazySingleton(() => ModificarClaseCDU(getIt()));
  getIt.registerLazySingleton(() => ObtenerClasePorIdCDU(getIt()));
  getIt.registerLazySingleton(() => ObtenerTodasLasClasesCDU(getIt()));
  getIt.registerLazySingleton(() => ObtenerHorarioPorIdDeClaseCDU(getIt()));

//PROVIDERS

  getIt.registerFactory<UsuarioProvider>(() => UsuarioProvider(
        getIt<CrearusuarioCDU>(),
        getIt<EliminarUsuarioCDU>(),
        getIt<ModificarUsuarioCDU>(),
        getIt<ObtenerTodosLosUsuariosCDU>(),
        getIt<ObtenerUsuarioPorIdCDU>(),
      ));
  getIt.registerFactory<ClasesProvider>(
    () => ClasesProvider(
      getIt<CrearClaseCDU>(),
      getIt<BorrarClaseCDU>(),
      getIt<ModificarClaseCDU>(),
      getIt<ObtenerClasePorIdCDU>(),
      getIt<ObtenerHorarioPorIdDeClaseCDU>(),
      getIt<ObtenerTodasLasClasesCDU>(),
    ),
  );
}
