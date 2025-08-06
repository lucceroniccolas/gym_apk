import 'package:flutter/material.dart';
import 'package:gym_apk/data/adapters/hive/models/inscripcion_model.dart';
import 'package:gym_apk/providers/inscripcion_provider.dart';
import 'package:gym_apk/providers/usuario_provider.dart';
import 'package:gym_apk/routes/app_routes.dart';
import 'package:provider/provider.dart';
import 'injection/injection_container.dart';
import 'ui/home_page.dart';
import 'providers/clases_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:gym_apk/data/adapters/hive/models/usuario_hive.dart'; // Importamos el modelo UsuarioHive para asegurarnos de que Hive lo reconozca
import 'package:gym_apk/data/adapters/hive/models/clase_model.dart'; // Importamos el modelo ClaseHive para asegurarnos de que Hive lo reconozca

void main() async {
  //inicializamos flutter y hive

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(
      UsuarioHiveAdapter()); // Registramos el adaptador de UsuarioHive

  Hive.registerAdapter(
      ClaseHiveAdapter()); // Registramos el adaptador de ClaseHive

  Hive.registerAdapter(
      InscripcionHiveAdapter()); // Registramos el adaptador de InscripcionHive

  //Sirve para guardar los objetos personalizados

  await init(); //inicializamos el contenedor de inyección de dependencias

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  //Construimos la app
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Usamos MultiProvider para inyectar los providers en la aplicación con sus dependencias (ya inyectadas por getIt )
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => getIt<ClasesProvider>()),
        ChangeNotifierProvider(create: (_) => getIt<InscripcionProvider>()),
        ChangeNotifierProvider(create: (_) => getIt<UsuarioProvider>()),
      ],

      //configuracion visual
      child: MaterialApp(
        home: const Homepage(),
        debugShowCheckedModeBanner: false,
        title: "GYM APK",
        //y de navegación de la app
        routes: AppRoutes.routes,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
      ),
    );
  }
}
