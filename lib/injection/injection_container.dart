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
import 'package:gym_apk/domain/repository/repo_inscripcion.dart';
import 'package:gym_apk/domain/services/coordinador_inscripciones.dart';

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
//Casos de uso---Inscripciones---
import 'package:gym_apk/domain/use_cases/gestionar_inscripcion/cancelar_inscripcion_cdu.dart';
import 'package:gym_apk/domain/use_cases/gestionar_inscripcion/inscribir_alumno_en_clase_cdu.dart';
import 'package:gym_apk/domain/use_cases/gestionar_inscripcion/obtener_clases_inscriptas_cdu.dart';
import 'package:gym_apk/domain/use_cases/gestionar_inscripcion/obtener_inscripciones_cdu.dart';
import 'package:gym_apk/domain/use_cases/gestionar_inscripcion/obtener_usuarios_inscriptos_cdu.dart';

//---Providers---
import 'package:gym_apk/providers/usuario_provider.dart';
import 'package:gym_apk/providers/clases_provider.dart';
import 'package:gym_apk/providers/inscripcion_provider.dart';

//Adaptadores

import 'package:gym_apk/data/adapters/hive/inscripcion_hive.dart';
import 'package:gym_apk/data/adapters/hive/models/inscripcion_model.dart';
//Adaptadores de memoria hive
import 'package:gym_apk/data/adapters/hive/usuarios_hive.dart';
import 'package:gym_apk/data/adapters/hive/models/usuario_hive.dart';
import 'package:gym_apk/data/adapters/hive/clases_hive.dart';
import 'package:gym_apk/data/adapters/hive/models/clase_model.dart';
import 'package:hive/hive.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // Esto significa: "Cuando alguien pida un RepoUsuario, devolvé esta instancia de HiveUsuarioImpl"
  //--ADAPTADORES--  (Usuarios)
  //Instancia única "perezosa" (adaptadores)
  final usuariosBox = await Hive.openBox<UsuarioHive>('usuariosBox');
  getIt.registerLazySingleton<RepoUsuario>(() => HiveUsuarioImpl(usuariosBox));
  //--ADAPTADORES-- (Clases)
  final claseBox = await Hive.openBox<ClaseHive>('clasesBox');

  getIt.registerLazySingleton<RepoClases>(() => HiveClasesImpl(claseBox));

  final inscripcionesBox =
      await Hive.openBox<InscripcionHive>('inscripcionesBox');
  //--ADAPTADORES-- (inscripción)

  getIt.registerLazySingleton<RepoInscripcion>(
      () => HiveInscripcionImpl(inscripcionesBox));

  getIt.registerLazySingleton(() => CoordinadorInscripciones(
        getIt<RepoInscripcion>(),
        getIt<RepoClases>(),
        getIt<RepoUsuario>(),
      ));

  _registarCasoDeUsoUsuario();
  _registrarCasoDeUsoClase();
  _registrarCasoDeUsoInscripciones();

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
//--PROVIDERS--(Inscripcion)
  getIt.registerFactory<InscripcionProvider>(
    () => InscripcionProvider(
      getIt<CancelarInscripcionCDU>(),
      getIt<InscribirAlumnoEnClaseCDU>(),
      getIt<ObtenerClasesInscriptasDeUsuarioCDU>(),
      getIt<ObtenerUsuariosInscriptosCDU>(),
      getIt<ObtenerInscripcionesCDU>(),
      getIt<ObtenerTodosLosUsuariosCDU>(),
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

  getIt.registerLazySingleton(() => EliminarUsuarioCDU(
        getIt<RepoUsuario>(),
        getIt<CoordinadorInscripciones>(),
      ));

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

// --USE CASES--//(registration)
void _registrarCasoDeUsoInscripciones() {
  getIt.registerLazySingleton(
      () => CancelarInscripcionCDU(getIt<CoordinadorInscripciones>()));
  getIt.registerLazySingleton(
      () => InscribirAlumnoEnClaseCDU(getIt<CoordinadorInscripciones>()));
  getIt.registerLazySingleton(
      () => ObtenerClasesInscriptasDeUsuarioCDU(getIt()));
  getIt.registerLazySingleton(() => ObtenerUsuariosInscriptosCDU(getIt()));
  getIt.registerLazySingleton(() => ObtenerInscripcionesCDU(getIt()));
}
