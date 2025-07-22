import 'package:flutter/material.dart';
import 'package:gym_apk/providers/inscripcion_provider.dart';
import 'package:gym_apk/providers/usuario_provider.dart';
import 'package:gym_apk/routes/app_routes.dart';
import 'package:provider/provider.dart';
import 'injection/injection_container.dart';
import 'ui/home_page.dart';
import 'providers/clases_provider.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //me ayuda a asegurar que flutter esté listo
  await init(); //preparamos e inyectamos todas las dependecias necesarias antes
  //que arranque la apk
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => getIt<ClasesProvider>()),
        ChangeNotifierProvider(create: (_) => getIt<InscripcionProvider>()),
        ChangeNotifierProvider(create: (_) => getIt<UsuarioProvider>()),
      ],
      child: MaterialApp(
        home: const Homepage(),
        debugShowCheckedModeBanner: false,
        title: "GYM APK",
        routes: AppRoutes.routes,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
      ),
    );
  }
}
