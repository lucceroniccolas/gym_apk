//¿Qué es get_it?

//patrón de diseño que centraliza la creación y acceso de servicios

//Inyectamos todas las dependencias del proyecto en un solo lugar

//----------------
//desacopla la creacion de objetos.
//----------------

//Mejora escalabilidad.
//Hace más fácil el testing.
//Limpia el codigo en el main y en los providers

//paquete get_it
import 'package:get_it/get_it.dart';

//---Repositorios---
import 'package:gym_apk/domain/repository/repo_usuario.dart';
import 'package:gym_apk/domain/repository/repo_clases.dart';
import 'package:gym_apk/domain/repository/repo_inscripcion.dart';

//---Coordinador de inscripciones---
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

//---Adaptadores de base de datos---

import 'package:gym_apk/data/adapters/hive/inscripcion_hive.dart';
import 'package:gym_apk/data/adapters/hive/models/inscripcion_model.dart';

import 'package:gym_apk/data/adapters/hive/usuarios_hive.dart';
import 'package:gym_apk/data/adapters/hive/models/usuario_hive.dart';

import 'package:gym_apk/data/adapters/hive/clases_hive.dart';
import 'package:gym_apk/data/adapters/hive/models/clase_model.dart';
import 'package:hive/hive.dart';

final getIt = GetIt.instance;

Future<void> init() async {
//Registro de cajas de Hive
  final usuariosBox = await Hive.openBox<UsuarioHive>('usuariosBox');
  final claseBox = await Hive.openBox<ClaseHive>('clasesBox');
  final inscripcionesBox =
      await Hive.openBox<InscripcionHive>('inscripcionesBox');

//Abrimos las cajas de Hive para poder usarlas como almacenamiento local

// Esto significa: "Cuando alguien pida un RepoUsuario,
// devolvé esta instancia de HiveImpl"
//Se usan registerLazySingleton, que crea una única instancia la primera vez que se necesita.
//--ADAPTADORES-- (Usuarios)

  getIt.registerLazySingleton<RepoUsuario>(() => HiveUsuarioImpl(usuariosBox));

  //--ADAPTADORES-- (Clases)

  getIt.registerLazySingleton<RepoClases>(() => HiveClasesImpl(claseBox));

  //--ADAPTADORES-- (inscripción)

  getIt.registerLazySingleton<RepoInscripcion>(
      () => HiveInscripcionImpl(inscripcionesBox));

//Registramos el coordinador de inscripciones
//servicio de dominio que maneja la lógica de inscripciones compleja
  getIt.registerLazySingleton(() => CoordinadorInscripciones(
        getIt<RepoInscripcion>(),
        getIt<RepoClases>(),
        getIt<RepoUsuario>(),
      ));

//Registramos los providers
//Los providers reciben los casos de uso correspondientes como parámetros del constructor.
//--PROVIDERS--(Usuario)
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
      getIt<ObtenerTodasLasClasesCDU>(),
    ),
  );
//--PROVIDERS--(Inscripcion)
  getIt.registerFactory<InscripcionProvider>(
    () => InscripcionProvider(
      getIt<InscribirAlumnoEnClaseCDU>(),
      getIt<CancelarInscripcionCDU>(),
      getIt<ObtenerClasesInscriptasDeUsuarioCDU>(),
      getIt<ObtenerUsuariosInscriptosCDU>(),
      getIt<ObtenerInscripcionesCDU>(),
      getIt<ObtenerTodosLosUsuariosCDU>(),
      getIt<ObtenerTodasLasClasesCDU>(),
    ),
  );

  //registramos los casos de uso
  _registarCasoDeUsoUsuario();
  _registrarCasoDeUsoClase();
  _registrarCasoDeUsoInscripciones();
}

// --CASOS DE USO--//(usuario)
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

// --CASOS DE USO--//(clase)
void _registrarCasoDeUsoClase() {
  getIt.registerLazySingleton(() => CrearClaseCDU(getIt()));
  getIt.registerLazySingleton(() => BorrarClaseCDU(getIt(), getIt()));
  getIt.registerLazySingleton(() => ModificarClaseCDU(getIt()));
  getIt.registerLazySingleton(() => ObtenerClasePorIdCDU(getIt()));
  getIt.registerLazySingleton(() => ObtenerTodasLasClasesCDU(getIt()));
}

// --USE CASES--//(inscripciones)
void _registrarCasoDeUsoInscripciones() {
  getIt.registerLazySingleton(
      () => CancelarInscripcionCDU(getIt<CoordinadorInscripciones>()));
  getIt.registerLazySingleton(
      () => InscribirAlumnoEnClaseCDU(getIt<CoordinadorInscripciones>()));
  getIt.registerLazySingleton(
      () => ObtenerClasesInscriptasDeUsuarioCDU(getIt(), getIt()));
  getIt.registerLazySingleton(
      () => ObtenerUsuariosInscriptosCDU(getIt(), getIt()));
  getIt.registerLazySingleton(() => ObtenerInscripcionesCDU(getIt()));
}
