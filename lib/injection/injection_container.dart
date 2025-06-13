//¿Qué es get_it?

//patrón de diseño que centraliza la creación y acceso de servicios

//Inyectar dependencias sin pasar objetos a mano.
//Reducir acoplamiento entre capas.
//Mejorar testeo y escalabilidad.

//Hace más fácil el testing.
//Limpia el codigo en el main y en los providers

//paquete get_it
import 'package:get_it/get_it.dart';
import 'package:gym_apk/data/adapters/memory/inscripciones.dart';
import 'package:gym_apk/domain/repository/repo_inscripcion.dart';
//---Repositorios---
import 'package:gym_apk/domain/repository/repo_usuario.dart';
import 'package:gym_apk/domain/repository/repo_clases.dart';
//casos de uso----Usuario----
import 'package:gym_apk/domain/use_cases/gestionar_usuario/eliminar_usuario.dart';
import 'package:gym_apk/domain/use_cases/gestionar_usuario/crear_usuario.dart';
import 'package:gym_apk/domain/use_cases/gestionar_usuario/modificar_usuario.dart';
import 'package:gym_apk/domain/use_cases/gestionar_usuario/obtener_usuario_por_id.dart';
import 'package:gym_apk/domain/use_cases/gestionar_usuario/obtener_todos_los_usuarios.dart';
// Casos de uso---Clase---
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

Future<void> init() async {
  //--ADAPTADORES--  (Usuarios)
  //Instancia única "perezosa" (adaptadores)
  getIt.registerLazySingleton<RepoUsuario>(() => MemoriaUsuarioImpl());
// Esto significa: "Cuando alguien pida un RepoUsuario, devolvé esta instancia (MemoriaUsuarioImpl)
  //--ADAPTADORES-- (Clase)
  getIt.registerSingleton<RepoClases>(MemoriaClasesImpl());

  _registarCasoDeUsoUsuario();
  _registrarCasoDeUsoClase();

  getIt.registerFactory<UsuarioProvider>(() => UsuarioProvider(
        getIt<CrearusuarioCDU>(),
        getIt<EliminarUsuarioCDU>(),
        getIt<ModificarUsuarioCDU>(),
        getIt<ObtenerTodosLosUsuariosCDU>(),
        getIt<ObtenerUsuarioPorIdCDU>(),
      ));
//--PROVIDERS--(Clase)
  //Instancia nueva cada vez que se pide
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

// --CASOS DE USO--//(Usuario)
void _registarCasoDeUsoUsuario() {
  getIt.registerLazySingleton(() => CrearusuarioCDU(getIt<RepoUsuario>()));
  getIt.registerLazySingleton(() => ModificarUsuarioCDU(getIt<RepoUsuario>()));
  getIt.registerLazySingleton(
      () => ObtenerUsuarioPorIdCDU(getIt<RepoUsuario>()));
  getIt.registerLazySingleton(() => EliminarUsuarioCDU(getIt<RepoUsuario>()));
  getIt.registerLazySingleton(
      () => ObtenerTodosLosUsuariosCDU(getIt<RepoUsuario>()));
}

// --CASOS DE USO--//(Clases)
void _registrarCasoDeUsoClase() {
  getIt.registerLazySingleton(() => CrearClaseCDU(getIt()));
  getIt.registerLazySingleton(() => BorrarClaseCDU(getIt()));
  getIt.registerLazySingleton(() => ModificarClaseCDU(getIt()));
  getIt.registerLazySingleton(() => ObtenerClasePorIdCDU(getIt()));
  getIt.registerLazySingleton(() => ObtenerTodasLasClasesCDU(getIt()));
  getIt.registerLazySingleton(() => ObtenerHorarioPorIdDeClaseCDU(getIt()));
}
